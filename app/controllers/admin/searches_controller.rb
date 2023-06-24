class Admin::SearchesController < ApplicationController

  before_action :authenticate_admin!

  def search
    @range = params[:range]

    if @range == "ユーザー"
      @users = User.find_records(params[:search], params[:word])
    elsif @range == "投稿"
      @posts = Post.find_records(params[:search], params[:word])
    elsif @range == "コメント"
      @comments = Comment.find_records(params[:search], params[:word])
    end

  end

end