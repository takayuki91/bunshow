class Public::ParagonsController < ApplicationController
  
  before_action :authenticate_user!
  
  def create
    @post = Post.find(params[:post_id])
    paragon = current_user.paragons.new(post_id: @post.id)
    paragon.save
    redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    paragon = current_user.paragons.find_by(post_id: @post.id)
    paragon.destroy
    redirect_to request.referer
  end
  
end
