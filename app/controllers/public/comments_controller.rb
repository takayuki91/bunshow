class Public::CommentsController < ApplicationController
  
  def create
    @currentpost = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @currentpost.id
    @comment.save
    redirect_to request.referer
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    @currentpost = Post.find(params[:post_id])
    redirect_to request.referer
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
