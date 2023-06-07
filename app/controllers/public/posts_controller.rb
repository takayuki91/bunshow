class Public::PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if  @post.save
      flash[:success] = "あなたのbunshowを共有しました!!"
      redirect_to posts_path
    else
      flash.now[:danger] = "共有するにはbunshowを入力してください"
      render :index
    end
  end

  def index
    @post = Post.new
    @posts = Post.all
  end

  def show
    @post = Post.new
    @currentpost = Post.find(params[:id])
  end
  
  def destroy
    @currentpost = Post.find(params[:id])
    @currentpost.destroy
    flash[:warning] = "あなたのbunshowを削除しました"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:post_image, :explanation)
  end


end
