class Admin::GroupsController < ApplicationController

  def show
    @user = User.find(params[:id])
    @groups = @user.groups.page(params[:page]).per(5)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:dark] = "グループを削除しました。"
    redirect_to admin_users_path
  end

end
