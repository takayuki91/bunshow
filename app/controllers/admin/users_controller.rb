class Admin::UsersController < ApplicationController

  def index
    @users = User.page(params[:page]).per(8)
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).order(created_at: :desc).page(params[:page]).per(9)
    # @currentpost = Post.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @currentpost = Post.find(params[:id])
    @currentpost.destroy
    flash[:dark] = "#{@user.name}のbunshowを削除しました。"
    redirect_to admin_user_path(@user.id)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:dark] = "#{@user.name}のユーザー情報を更新しました。"
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :is_deleted)
  end

end
