class OrdersController < ApplicationController
  before_action :only_auth_resource
  before_action :def_current_order
  skip_before_action :def_current_order, only: [:index, :show]

  @@checkout_routes = {
    Customer.cart_states[1] => :checkout_address,
    Customer.cart_states[2] => :checkout_delivery,
    Customer.cart_states[3] => :checkout_payment,
    Customer.cart_states[4] => :checkout_confirm,
    Customer.cart_states[5] => :checkout_complete}

  def index
    @order = @current_customer.get_current_order
    @completed_orders = @current_customer.get_orders(:completed)
    @shipped_orders = @current_customer.get_orders(:shipped)
  end
  
  def show
    @order = Order.find_by_id(params[:id]) || not_found

    if @order.items.empty?
      @order.destroy
      redirect_to :shop
    end
  end
  
  def edit
    select_cart_step
  end

  def new_item
    new_item = @order.add_book(params[:book_id], params[:quantity])
    new_item.valid?

    render :edit
  end

  def update
    @order.items.each do |item|
      item_num = item.new_record? ? "new_item" : "item_#{item.id}"
      if params["#{item_num}_del_flag"] == '1'
        item.destroy
      end
    end

    is_valid = true
    @order.items.each do |item|
      next if item.destroyed?
      
      new_quantity = params["item_#{item.id}_qty"].to_i
      if item.quantity != new_quantity
        item.quantity = new_quantity
        item.save
      end

      is_valid = item.valid? if is_valid
    end

    # new item
    if params[:new_item_qty] && params[:new_item_del_flag] != '1'
      new_item = @order.add_book(params[:new_item_book_id], params[:new_item_qty])
      is_valid = new_item.valid? if is_valid
    end

    if is_valid
      redirect_to @order
    else
      render :edit
    end
  end
  
  def empty_cart
    @order.items.each do |item|
      item.destroy
    end
    
    redirect_to :root
  end

  def checkout_address
    @order.init_addresses

    if @current_customer.cart_state == Customer.default_cart_state
      @current_customer.cart_state = 'address'
      @current_customer.save
    end

    render_checkout 'address'
  end
  
  def save_cart_address
    if @order.save_adresses(address_checkout_params)
      if step_num('delivery') > step_num(@current_customer.cart_state)
          @current_customer.cart_state = 'delivery'
          @current_customer.save
      end
      @order.save
      redirect_to :checkout_delivery

    else
      render_checkout 'address'
    end
  end
    
  def checkout_delivery
    unless is_correct_cart_step?('delivery')
      select_cart_step
      return
    end

    @order.init_shipping
    render_checkout 'delivery'
  end
  
  def save_cart_delivery
    delivery_params = delivery_checkout_params
    @order.shipping = delivery_params[:shipping]
    if @order.valid?
      if step_num('payment') > step_num(@current_customer.cart_state)
        @current_customer.cart_state = 'payment'
        @current_customer.save
      end
      @order.save
      redirect_to :checkout_payment
    
    else
      render_checkout 'delivery'
    end
  end
  
  def checkout_payment
    # @var1 = step_num('payment')
    # @var2 = step_num(@current_customer.cart_state)
    # @var4 = @var2 >= @var1

    # @card = @current_customer.get_credit_card!
    # render :tmp
    # return
    
    unless is_correct_cart_step?('payment')
      select_cart_step
      return
    end

    @card = @current_customer.get_credit_card!
    render_checkout 'payment'
  end
  
  def save_cart_payment
    @card = @current_customer.get_credit_card!
    @card.attributes = payment_checkout_params

    if @card.valid?
      if step_num('confirm') > step_num(@current_customer.cart_state)
          @current_customer.cart_state = 'confirm'
          @current_customer.save
      end

      @card.save
      @card.save_links @current_customer, @order
      
      redirect_to :checkout_confirm
    else
      render_checkout 'payment'
    end
  end
  
  def checkout_confirm
    unless is_correct_cart_step?('confirm')
      select_cart_step
      return
    end

    render_checkout 'confirm'
  end
  
  def checkout_complete
    @current_customer.cart_state = 'in_progress'
    @current_customer.save

    @order.state = 'completed'
    @order.completed_date = Date.today
    @order.save
    
    render_checkout 'complete'
  end
  
  private

  def def_current_order
    @order = @current_customer.get_current_order!
  end

  def select_cart_step
    order = @current_customer.get_current_order
    if !order 
      redirect_to :shop
    elsif order.items.empty?
      redirect_to :shop
    elsif @current_customer.cart_state != Customer.default_cart_state
      redirect_to @@checkout_routes[@current_customer.cart_state]
    end
  end
  
  def  is_correct_cart_step?(sel_step)
    sel_step_num = step_num(sel_step)
    current_step_num = step_num(@current_customer.cart_state)
    return current_step_num >= sel_step_num
  end
  
  def step_num(step)
    Customer.cart_states.find_index(step)
  end

  def render_checkout(checkout_action)
    render "orders/checkout_#{checkout_action}"
  end

  def address_checkout_params
    addr_params = Hash.new
    addr_params[:billing_address] = params.require(:order).require(:billing_address).permit(:id, :first_name, :last_name, :address, :city, :country_id, :zip_code, :phone)
    addr_params[:shipping_address] = params.require(:order).require(:shipping_address).permit(:id, :first_name, :last_name, :address, :city, :country_id, :zip_code, :phone)
    addr_params[:order] = params.require(:order).permit(:one_address)
    addr_params
  end
  
  def delivery_checkout_params
    params.permit(:shipping);
  end
  
  def payment_checkout_params
    params.permit(:number, :CVV, :expiration_month, :expiration_year)
  end
  
end
