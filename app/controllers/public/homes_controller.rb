class Public::HomesController < ApplicationController

  def top
    @today_posts_count = Post.where("DATE(created_at) = ?", Date.today)
                             .count
  end
  
  def privacy
  end

end
