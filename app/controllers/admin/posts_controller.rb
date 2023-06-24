class Admin::PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @user = @post.user
    @post.destroy
    flash[:danger] = "ユーザーのbunshowを削除しました"
    redirect_to admin_user_path(@user)
  end

end