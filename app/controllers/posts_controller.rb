class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @current_user = current_user
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @post = Post.new
    @current_user = current_user
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:notice] = 'The post have been created successfully'
      redirect_to user_posts_path(@post.author_id)
    else
      flash[:alert] = 'Adding a new post failed.'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:author_id, :title, :text).tap do |post_params|
      post_params.require(:text)
    end
  end
end
