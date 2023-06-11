class Admin::PostsController < ApplicationController
  
  def show
    @currentpost = Post.find(params[:id])
  end
  
  def destroy
    @currentpost = Post.find(params[:id])
    @currentpost.destroy
    flash[:dark] = "あなたのbunshowを削除しました"
    redirect_to admin_user_path(@currentpost.user.id)
  end
  
end
