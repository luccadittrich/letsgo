class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :notifications

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :bio, :photo, :username])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :bio, :photo, :banner, :username])
  end

  def after_sign_in_path_for(_resource_or_scope)
    home_path
  end

  def notifications
    @notifications = current_user.notifications
    @chatrooms = Chatroom.where(user: current_user).or(Chatroom.where(followed: current_user)).to_a
  end
end
