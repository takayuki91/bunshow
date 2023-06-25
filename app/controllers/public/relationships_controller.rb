class Public::RelationshipsController < ApplicationController

  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    follow = current_user.active_relationships
                         .new(followed_id: params[:user_id])
    follow.save
  end

  def destroy
    @user = User.find(params[:user_id])
    follow = current_user.active_relationships
                         .find_by(followed_id: params[:user_id])
    follow.destroy
  end

end
