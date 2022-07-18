class Publics::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_customer, only: [:edit]

  def show
    @customer = Customer.find(params[:id])
    if @customer != current_customer
      redirect_to customer_path(current_customer), notice: "リクエストされたページには遷移できません"
    else
      posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : @customer.posts
      @posts = posts.page(params[:page]).per(6)
    end
  end

  def quit
    @customer = current_customer
    redirect_to_mypage(@customer)
  end

  def out
    @customer = current_customer
    @customer.update(status: false)
    reset_session
    redirect_to root_path, notice: "退会しました"
  end

  def edit
    @customer = Customer.find(params[:id])
    if @customer != current_customer
      redirect_to customer_path(current_customer), notice: "他人の編集ページには遷移できません"
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "会員情報を変更しました"
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :name_kana, :nickname, :email, :phone_number, :status, :profile_image)
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    redirect_to_mypage(@customer)
  end

  def redirect_to_mypage(customer)
    if customer.name == "guestcustomer"
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはリクエストされたページには遷移できません。'
    end
  end
end
