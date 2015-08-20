class ApplicationController < ActionController::Base
  attr_reader :current_customer

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate

  def page_404
    render 'public/404.html'
  end

  def not_found
    redirect_to '/404'
  end

  private

  def authenticate
    @current_customer = Customer.find_by_id(session[:customer_id])
  end

  def only_auth_resource
    @current_customer || not_found
  end
end
