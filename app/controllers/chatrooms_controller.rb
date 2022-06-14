class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.where(user: current_user).or(Chatroom.where(followed: current_user)).to_a
  end

  def create
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    @chatroom_name = "#{@chatroom.user.username} - #{@chatroom.followed.username}"
  end
end
