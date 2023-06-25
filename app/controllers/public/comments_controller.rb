class Public::CommentsController < ApplicationController

  before_action :authenticate_user!
  
  def create
    @currentpost = Post.find(params[:post_id])
    @comment = current_user.comments
                           .new(comment_params)
    @comment.post_id = @currentpost.id
    if @comment.save
      @comment = Comment.new
      flash[:dark] = "フィードバックを共有しました!!"
      redirect_to request.referer
    else
      flash[:danger] = "フィードバックの文字数は100文字までです。"
      redirect_to post_path(@currentpost.id)
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    @currentpost = Post.find(params[:post_id])
    flash[:dark] = "フィードバックを削除しました。"
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
