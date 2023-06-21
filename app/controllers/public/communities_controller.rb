class Public::CommunitiesController < ApplicationController

  before_action :authenticate_user!

  def edit
    @user = current_user
    @communities = Community.all
  end

  def update
    @user = current_user
    @user.community_ids = params[:user][:community_ids]
    if @user.save
      flash[:dark] = "コミュニティを更新しました!!"
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "コミュニティの更新に失敗しました。"
      render :edit
    end
  end

end
