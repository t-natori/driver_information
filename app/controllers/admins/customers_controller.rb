class Admins::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admins_customer_path, notice: "会員情報を更新しました"
    else
      render :edit
    end
  end




  private

  def customer_params
    params.require(:customer).permit(:name, :name_kana, :nickname, :email, :phone_number, :status)
  end
end
