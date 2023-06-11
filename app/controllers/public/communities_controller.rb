class Public::CommunitiesController < ApplicationController
  
  def index
    @communities = Community.all
  end
  
  def join
    @community = Community.find(params[:id])
    current_user.communities << @community
    flash[:dark] = "コミュニティに参加しました!!"
    redirect_to communities_path
  end
  
end
