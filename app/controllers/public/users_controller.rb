class Public::UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :follows, :followeds, :bookmarks ]

  def index
  end

  def show
    @posts = @user.posts
  end

  def edit
  end

  def update
    @user.update(user_params)
    flash[:dark] = "あなたのユーザー情報を更新しました!!"
    redirect_to user_path(@user.id)
  end

  def follows
    @users = @user.follows
  end

  def followeds
    @users = @user.followeds
  end

  def bookmarks
    bookmarks = Bookmark.where(user_id: @user.id).pluck(:post_id)
    @posts = Post.find(bookmarks)
  end

  def unsubscribe
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    #セッション情報を全て削除（セキュリティ面のリスク回避のため）
    reset_session
    flash[:info] = "退会処理を実行いたしました。"
    redirect_to root_path

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

end
