class AuthController < ApplicationController
  skip_before_action :authenticate

  def index
    @customer = Customer.new
  end

  def sign_in
    @customer = Customer.find_by(email: params[:email])

    if !@customer
      @customer = Customer.new
      @customer.errors.add(:email, 'Cannot authenticate customer by email ' + params[:email])
      render :index
    elsif !@customer.authenticate(params[:password])
      @customer = Customer.new
      @customer.errors.add(:password, 'Incorrect password for ' + params[:email])
      render :index
    else
      session[:customer_id] = @customer.id
      redirect_to :root
    end
  end

  def sign_out
    @current_customer = nil
    session[:customer_id] = nil
    reset_session
    redirect_to :root
  end

end
