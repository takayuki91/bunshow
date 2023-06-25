class Public::GroupUsersController < ApplicationController

  before_action :authenticate_user!

  def create
    group_user = current_user.group_users
                             .new(group_id: params[:group_id])
    group_user.save
    flash[:dark] = "ラボに参加しました!!"
    redirect_to request.referer
  end

  def destroy
    group_user = current_user.group_users
                             .find_by(group_id: params[:group_id])
    group_user.destroy
    flash[:dark] = "ラボを退会しました。"
    redirect_to request.referer
  end
end
