class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :notifications

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name bio photo username])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[first_name last_name bio photo banner username])
  end

  def after_sign_in_path_for(_resource_or_scope)
    home_path
  end

  def notifications
    return unless current_user

    @notifications = current_user.notifications
    if current_user_on_notifications_page # Substitua por sua lógica de verificação da página de notificações
      @notifications.update(viewed: true)
    end
    @notifications_number = @notifications.count
    @notifications.each do |notification|
      @notifications_number -= 1 if notification.viewed
    end
    @chatrooms = Chatroom.where(user: current_user).or(Chatroom.where(followed: current_user)).to_a
  end

  def current_user_on_notifications_page
    # Lógica para verificar se o current_user está na página de notificações
    # Por exemplo, você pode verificar a rota atual ou o controller/action sendo usado
    puts "____________________________________________________"
    puts "11111111"
    # Exemplo 1: Verificar a rota atual
    return true if request.path == "/notifications" # Verifica se a rota atual é "/notifications"

    puts "____________________________________________________"
    puts "passssssssssou"
    # Exemplo 2: Verificar o controller/action atual
    if params[:controller] == "notifications" && params[:action] == "index" # Verifica se o controller é "notifications" e a action é "index"
      return true
    end

    puts "____________________________________________________"
    puts "falsseeeeeeee"
    false
  end
end
