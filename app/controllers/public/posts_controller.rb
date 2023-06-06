class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if  @item.save
      flash[:success] = "あなたのbunshowを共有しました!!"
      redirect_to posts_path(@post)
    else
      flash.now[:danger] = "bunshowを入力してください"
      render :index
    end
  end
  
  def index
    @posts = Post.all
  end
  
  def show
  end
  
  def edit
  end
  
  def post_params
    params.require(:post).permit(:post_images, :explanation)
  end
    

end
