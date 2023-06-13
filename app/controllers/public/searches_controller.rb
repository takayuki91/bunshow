class Public::SearchesController < ApplicationController

  before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "指導者"
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word]).joins(:user).where(user: { is_deleted: false }).order(created_at: :desc)
    end
  end
end
