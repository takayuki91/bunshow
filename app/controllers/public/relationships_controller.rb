class Public::RelationshipsController < ApplicationController
  
  before_action :authenticate_user!
  
  def create
    follow = current_user.active_relationships.new(followed_id: params[:user_id])
    follow.save
    redirect_to request.referrer
  end

  def destroy
    follow = current_user.active_relationships.find_by(followed_id: params[:user_id])
    follow.destroy
    redirect_to request.referrer
  end
  
end
