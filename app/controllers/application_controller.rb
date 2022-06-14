class ApplicationController < ActionController::Base
  # ユーザ登録、ログイン認証などが使われる前にconfigure_permitted_parametersメソッドを実行
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    if resource_class == Customer
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :name_kana, :nickname, :email, :phone_number])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:nickname, :email])
      devise_parameter_sanitizer.permit(:sign_update, keys: [:name, :name_kana, :nickname, :email, :phone_number])
    else
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
    end
  end
end
