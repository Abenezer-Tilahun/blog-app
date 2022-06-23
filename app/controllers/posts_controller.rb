class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @user = User.includes(:posts).find(params[:user_id])
    @current_user = current_user
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:comments, :likes).find(params[:id])
  end

  def new
    @post = Post.new
    @current_user = current_user
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.likes_counter = 0
    @post.comments_counter = 0

    if @post.save
      flash[:notice] = 'The post have been created successfully'
      redirect_to user_posts_path(@post.author_id)
    else
      flash[:alert] = 'Adding a new post failed.'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find(params[:id])
    user = User.find(post.author_id)
    user.posts_counter -= 1
    post.destroy
    user.save
    flash[:alert] = 'You have deleted this post successfully!'
    redirect_to user_posts_path(post.author_id)
  end

  private

  def post_params
    params.require(:post).permit(:author_id, :title, :text).tap do |post_params|
      post_params.require(:text)
    end
  end
end
