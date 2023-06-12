class Admin::CommentsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @comments = @user.comments
  end

end
