class Admin::HomesController < ApplicationController
  
  def top
    @posts = Post.includes(:user).where(users: { is_deleted: false }).order(created_at: :desc)
    # 本日の投稿のうち、有効ユーザーのもの
    @today_posts_count = Post.where("DATE(created_at) = ?", Date.today).count
  end
  
end
