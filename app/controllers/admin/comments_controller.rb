class Admin::CommentsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @comments = @user.comments.page(params[:page]).per(8)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @user = @comment.user
    @comment.destroy
    redirect_to admin_user_comments_path(@user.id)
  end

end
