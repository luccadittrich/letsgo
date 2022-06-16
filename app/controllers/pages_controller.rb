class PagesController < ApplicationController
  def home
    @post = Post.new
    @check_ins = CheckIn.where(user_id: current_user)
    @user = current_user
    @posts = Post.all.select { |p| p.user.id = current_user.id || current_user.follows.any? { |f| f[:followed_id] == p.user.id} }
    @widget = 'home'
    @sidebar = 'home'
    @feed_header = 'home'
    @events = Event.all
    @check_in_event = current_user.check_ins.map do |c|
                        c.event
                      end



    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        image_url: helpers.asset_url("house.png")
      }
    end
  end

  def update_address
    current_user.address = user_params[:address]
    current_user.save
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:address)
  end
end
