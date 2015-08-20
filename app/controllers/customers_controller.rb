class CustomersController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]
  before_action :only_auth_resource, only: [:edit]

  def new
    @customer = Customer.new
  end
  
  def edit
    @customer = @current_customer
    @customer.init_addresses
    @test = 10
  end
  
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      session[:customer_id] = @customer.id
      redirect_to root_path
    else
      render :new
    end
  end
  
  def test_action
    redirect_to root_path
  end
      
  def update
    @customer = @current_customer
    if @customer.update_settings(customer_settings_params)
      @customer.save
      redirect_to root_path
    else
      render :edit
    end
  end
  
  private

  def customer_params
    params.require(:customer).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
  
  def customer_settings_params
    settings_params = Hash.new
    settings_params[:customer] = params.require(:customer).permit(:first_name, :last_name, :email)
    settings_params[:billing_address] = params.require(:customer).require(:billing_address).permit(:id, :first_name, :last_name, :address, :city, :country_id, :zip_code, :phone)
    settings_params[:shipping_address] = params.require(:customer).require(:shipping_address).permit(:id, :first_name, :last_name, :address, :city, :country_id, :zip_code, :phone)
    settings_params[:password] = params.require(:password).permit(:current, :new)
    
    settings_params
  end

end
