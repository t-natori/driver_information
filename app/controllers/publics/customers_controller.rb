class Publics::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
    @posts = @customer.posts
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id)
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :name_kana, :nickname, :email, :phone_number, :status)
  end

end
