class Admin::HomesController < ApplicationController

  def top
    @posts = Post.includes(:user)
                 .where(users: { is_deleted: false })
                 .order(created_at: :desc)

    @today_posts_count = Post.where("DATE(created_at) = ?", Date.today)
                             .count
  end

end