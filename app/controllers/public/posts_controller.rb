class Public::PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if  @post.save
      flash[:dark] = "あなたのbunshowを共有しました!!"
      redirect_to posts_path
    else
      flash[:danger] = "BunShowの文字数は100文字までです。"
      redirect_to posts_path
    end
  end

  def index
    @post = Post.new
    if current_user.communities.present?

      # ユーザーが所属するコミュニティとその子孫コミュニティのIDを取得
      # 重複を除いて一つの配列にまとめる
      community_ids = current_user.communities
                                  .map(&:subtree_ids)
                                  .flatten

      # コミュニティに所属するユーザーに限定
      # 上記で取得したコミュニティのIDに該当するユーザーIDを取得
      community_user_ids = User.joins(:communities)
                               .where(communities: { id: community_ids })
                               .pluck(:id)

      # ユーザーが削除されていないかつ、上記で取得したユーザーIDに該当する投稿を取得
      # 作成日時の降順で並び替える
      @posts = Post.includes(:user)
                   .where(users: { is_deleted: false, id: community_user_ids })
                   .order(created_at: :desc)
                   .page(params[:page]).per(9)
    else
      @posts = Post.includes(:user)
                   .where(users: { is_deleted: false })
                   .order(created_at: :desc)
                   .page(params[:page]).per(9)
    end
  end

  def likes
    @posts = Post.joins(:likes, :user)
                 .where(users: { is_deleted: false })
                 .group('posts.id')
                 .order('COUNT(likes.id) DESC, posts.created_at DESC')
                 .page(params[:page]).per(9)
  end

  def paragons
    @posts = Post.joins(:paragons, :user)
                 .where(users: { is_deleted: false })
                 .group('posts.id')
                 .order('COUNT(paragons.id) DESC, posts.created_at DESC')
                 .page(params[:page]).per(9)
  end

  def show
    @currentpost = Post.find(params[:id])

    # currentユーザーのコメントがあるか確認するため
    # 詳細ページのみコントローラーに記述
    @user_comments = @currentpost.comments
                                 .where(user_id: current_user.id)

    # 閲覧数をカウントする
    if current_user.name != "guestuser"
      unless Paragon.where(created_at: Time.zone.now.all_day)
                    .find_by(user_id: current_user.id, post_id: @currentpost.id)
        current_user.paragons
                    .create(post_id: @currentpost.id)
      end
    end
    @comment = Comment.new
    @comments = @currentpost.comments
                            .order(created_at: :desc)
                            .page(params[:page]).per(10)
  end

  def edit
    @currentpost = Post.find(params[:id])
  end

  def update
    @currentpost = Post.find(params[:id])
    if @currentpost.update(post_params)
      flash[:dark] = "あなたのBunsShowを更新しました!!"
      redirect_to post_path(@currentpost.id)
    else
      flash[:danger] = "BunShowの文字数は100文字までです。"
      redirect_to edit_post_path(@currentpost.id)
    end
  end

  def destroy
    @currentpost = Post.find(params[:id])
    @currentpost.destroy
    flash[:dark] = "あなたのbunshowを削除しました"
    redirect_to user_path(current_user.id)
  end

  private

  def post_params
    params.require(:post).permit(:post_image, :explanation)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id
      flash[:danger] = "このBunShowへの編集権限はありません。"
      redirect_to posts_path
    end
  end

end
