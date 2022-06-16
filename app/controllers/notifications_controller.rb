class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications
    @feed_header = 'notifications'
  end
end
