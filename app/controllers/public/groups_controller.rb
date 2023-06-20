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
      flash[:danger] = "ラボの名前は20文字まで、紹介は100文字までです。"
      redirect_to groups_path
    end
  end

  def index
    @group = Group.new
    @groups = Group.all.page(params[:page]).per(10)
  end

  def show
    @group = Group.find(params[:id])
    @posts = []
    @group.users.each do |user|
      @posts.concat(user.posts)
    end
    @posts.sort_by! { |post| post.created_at }.reverse!
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(9)
  end

  def users
    @group = Group.find(params[:id])
    @users = @group.users.where(users: { is_deleted: false }).page(params[:page]).per(10)
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:dark] = "ラボ情報を更新しました!!"
      redirect_to groups_path
    else
      flash[:danger] = "ラボの名前は20文字まで、紹介は100文字までです。"
      redirect_to edit_group_path(@group.id)
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:dark] = "ラボを解散しました。"
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
