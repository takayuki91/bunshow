class Public::UsersController < ApplicationController

  before_action :authenticate_user!

  before_action :set_user, only: [:show, :edit, :update, :follows, :followeds, :bookmarks ]

  before_action :check_deleted_user, only: [:show]
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def show
    @posts = @user.posts
                  .order(created_at: :desc)
                  .page(params[:page]).per(9)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:dark] = "あなたの指導者情報を更新しました!!"
      redirect_to user_path(@user.id)
    else
      flash[:danger] = "ニックネーム(2〜20文字)とアドレスは固有のものにしてください。"
      render :edit
    end
  end

  def follows
    @users = @user.follows
                  .where(is_deleted: false)
                  .page(params[:page]).per(10)
  end

  def followeds
    @users = @user.followeds
                  .where(is_deleted: false)
                  .page(params[:page]).per(10)
  end

  def bookmarks
    bookmarks = Bookmark.where(user_id: @user.id)
                        .pluck(:post_id)
    @posts = Post.joins(:bookmarks)
                 .joins(:user)
                 .where(users: { is_deleted: false })
                 .where(id: bookmarks)
                 .group('posts.id')
                 .page(params[:page]).per(9)
  end

  def unsubscribe
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:dark] = "退会処理を実行いたしました。"
    redirect_to root_path

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # 退会ユーザーのページに遷移できないようにする
  def check_deleted_user
    user = User.find(params[:id])
    if user.is_deleted?
      flash[:danger] = "お探しの指導者が見つかりません。"
      redirect_to user_path(current_user.id)
    end
  end

  # 本人のみが編集可能にする
  def ensure_correct_user
    unless @user == current_user
      flash[:danger] = "このアクセスは許可されていません。"
      redirect_to user_path(current_user.id)
    end
  end

  # ゲストユーザー編集ページへのurl直接入力を防ぐ
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      flash[:danger] = "ゲストユーザーはプロフィール編集画面へアクセスできません。"
      redirect_to user_path(current_user.id)
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end

end