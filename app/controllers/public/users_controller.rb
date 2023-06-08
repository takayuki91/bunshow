class Public::UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:dark] = "あなたのユーザー情報を更新しました!!"
    redirect_to user_path(@user.id)
  end
  
  def follows
    @user = User.find(params[:id]) 
    @users = @user.follows
  end
  
  def followeds
    @user = User.find(params[:id]) 
    @users = @user.followeds
  end

  def unsubscribe
  end

  def withdraw
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

end
