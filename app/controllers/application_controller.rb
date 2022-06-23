class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :name, :photo, :bio, :posts_counter, :password, :password_confirmation, :role)
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email, :name, :photo, :bio, :password, :password_confirmation, :current_password, :role)
    end
  end
end
