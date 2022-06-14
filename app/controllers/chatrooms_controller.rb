class ChatroomsController < ApplicationController
  def index
  end

  def create
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end
end
