class ApplicationController < ActionController::Base
  # ユーザ登録、ログイン認証などが使われる前にconfigure_permitted_parametersメソッドを実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  add_flash_types :success, :info, :warning, :danger

  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :name_kana, :nickname, :email, :phone_number])
  end
end
