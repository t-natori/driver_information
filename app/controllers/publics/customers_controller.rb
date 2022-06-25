class Publics::CustomersController < ApplicationController
  before_action :authenticate_customer!
  # before_action :ensure_customer
  before_action :ensure_guest_customer, only: [:edit, :quit]

  def show
    @customer = Customer.find(params[:id])
    if @customer != current_customer
      redirect_to customer_path(current_customer), notice: "リクエストされたページには遷移できません"
    else
      posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : @customer.posts
      @posts = posts.page(params[:page]).per(7)
    end
  end

  def quit
    @customer = Customer.find(params[:id])
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
      redirect_to customer_path(current_customer) , notice: 'リクエストされたページには遷移できません。'
    end
  end
end
