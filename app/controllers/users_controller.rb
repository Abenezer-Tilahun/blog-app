class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'The user has been updateduccessfully'
      redirect_to root_path(@user.id)
      # Handle a successful update.
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :role, :password, :password_confirmation)
  end
end
