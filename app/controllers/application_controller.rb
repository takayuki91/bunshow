class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_admin!, only: [:guest_sign_in], if: :admin_url

  # フラッシュメッセージの色指定
  add_flash_types :success, :info, :warning, :danger, :light, :dark

  # 管理者のurlを直接入力した際にログイン画面に
  def admin_url
    request.fullpath.include?("/admin")
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
