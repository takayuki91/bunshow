class Public::PostsController < ApplicationController

  before_action :authenticate_user!

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if  @post.save
      flash[:dark] = "あなたのbunshowを共有しました!!"
      redirect_to posts_path
    else
      flash.now[:danger] = "共有するにはbunshowを入力してください"
      render :index
    end
  end

  def index
    @post = Post.new
    if current_user.communities.present?
      # ユーザーが所属するコミュニティとその子孫コミュニティのIDを取得し、重複を除いて一つの配列にまとめる
      community_ids = current_user.communities.map(&:subtree_ids).flatten
      # コミュニティに所属するユーザーの中で、上記で取得したコミュニティのIDに該当するユーザーのIDを取得する
      community_user_ids = User.joins(:communities).where(communities: { id: community_ids }).pluck(:id)
      # ユーザーが削除されていないかつ、上記で取得したユーザーIDに該当する投稿を取得し、作成日時の降順で並び替える
      @posts = Post.includes(:user).where(users: { is_deleted: false, id: community_user_ids }).order(created_at: :desc)
    else
      @posts = Post.includes(:user).where(users: { is_deleted: false }).order(created_at: :desc)
    end
  end

  def likes
    @posts = Post.joins(:likes, :user)
                 .where(users: { is_deleted: false })
                 .group('posts.id')
                 .order('COUNT(likes.id) DESC, posts.created_at DESC')
  end

  def paragons
    @posts = Post.joins(:paragons, :user)
                 .where(users: { is_deleted: false })
                 .group('posts.id')
                 .order('COUNT(paragons.id) DESC, posts.created_at DESC')
  end

  def show
    @post = Post.new
    @currentpost = Post.find(params[:id])
    if current_user.name != "guestuser"
      unless Paragon.where(created_at: Time.zone.now.all_day).find_by(user_id: current_user.id, post_id: @currentpost.id)
        current_user.paragons.create(post_id: @currentpost.id)
      end
    end
    @comment = Comment.new
  end

  def destroy
    @currentpost = Post.find(params[:id])
    @currentpost.destroy
    flash[:dark] = "あなたのbunshowを削除しました"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:post_image, :explanation)
  end


end
