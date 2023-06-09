class Public::SearchesController < ApplicationController

  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "指導者"
      @users = User.looks(params[:search], params[:word])
                   .where(users: { is_deleted: false })
                   .page(params[:page]).per(10)

    elsif @range == "BunShow"
      @posts = Post.looks(params[:search], params[:word])
                   .joins(:user)
                   .where(user: { is_deleted: false })
                   .order(created_at: :desc)
                   .page(params[:page]).per(9)

    elsif @range == "ラボ"
      @groups = Group.looks(params[:search], params[:word])
                     .order(created_at: :desc)
                     .page(params[:page]).per(9)

    end
  end
end
