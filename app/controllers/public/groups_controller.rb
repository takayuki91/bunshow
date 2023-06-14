class Public::GroupsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      flash[:dark] = "グループを立ち上げました!!"
      redirect_to groups_path
    else
      render "index"
    end
  end

  def index
    @group = Group.new
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @posts = []
    @group.users.each do |user|
      @posts.concat(user.posts)
    end
    @posts.sort_by! { |post| post.created_at }.reverse!
  end
  
  def users
    @group = Group.find(params[:id])
    @users = @group.users
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:dark] = "グループ情報を更新しました!!"
      redirect_to groups_path
    else
      render "edit"
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:dark] = "グループを解散しました。"
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_profile_image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

end
