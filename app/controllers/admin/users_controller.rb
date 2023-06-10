class Admin::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    
  end

  def destroy
    @user = User.find(params[:id])
    @currentpost = Post.find(params[:id])
    @currentpost.destroy
    flash[:dark] = "#{@user.name}のbunshowを削除しました。"
    redirect_to posts_path
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
