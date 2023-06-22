# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  before_action :customer_state, only: [:create]

  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    flash[:dark] = "ゲスト指導者としてログインしました。"
    redirect_to edit_community_path(user.id)
  end

  protected

  #退会しているか判断するメソッド
  def customer_state
    # 入力されたemailからアカウントを１件取得
    @user = User.find_by(email: params[:user] [:email])
    # アカウントを取得できなかった場合、このメソッドを修了する
    return if !@user
    # 取得したアカウントのパスワードと入力されたパスワードが一致している、かつis_deletedカラムがtrue(退会済み)判別
    if @user.valid_password?(params[:user] [:password] ) && (@user.is_deleted == true )
      flash[:danger] = "退会済みです。再度ご登録をしてご利用ください"
      redirect_to new_user_registration_path
    end
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
