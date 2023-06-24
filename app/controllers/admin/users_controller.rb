class Admin::UsersController < ApplicationController

  before_action :set_user, only: [:edit, :show, :destroy, :update ]

  def index
    @users = User.page(params[:page]).per(8)
  end

  def edit
  end

  def show
    @posts = Post.where(user_id: @user.id)
                 .order(created_at: :desc)
                 .page(params[:page]).per(9)
  end

  def destroy
    @user.destroy
    flash[:danger] = "この会員の全ての情報を削除しました。"
    redirect_to admin_users_path
  end

  def update
    @user.update(user_params)
    flash[:dark] = "#{@user.name}のユーザー情報を更新しました。"
    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :is_deleted)
  end

end