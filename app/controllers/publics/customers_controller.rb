class Publics::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_customer
  before_action :ensure_guest_customer, only: [:edit]

  def show
    @customer = current_customer
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : @customer.posts
  end

  def quit
    @customer = current_customer
  end

  def out
    @customer = current_customer
    @customer.update(status: false)
    reset_session
    redirect_to root_path

  end

  def edit
    @customer = Customer.find(params[:id])
    if @customer != current_customer
      redirect_to customer_path(current_customer), notice: "このページにはアクセスできません"
    end
  end
  def update
    @customer = Customer.find(params[:id])
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :name_kana, :nickname, :email, :phone_number, :status)
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.name == "guestcustomer"
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def ensure_customer
    @customer = Customer.find(params[:id])
    if @customer != current_customer
      redirect_to customer_path(current_customer) , notice: 'このページには遷移できません。'
    end
  end
end
