class ProfilesController < ApplicationController
  def show
    @posts = Post.where(user: params[:id])
    @feed_header = 'profile'
    @widget = 'profile'
    @check_ins = CheckIn.where(user_id: current_user)
    @user = User.find(params[:id])
    @follows = Follow.find_by(user_id: current_user.id, followed_id: params[:id])
    @events = Event.all
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        image_url: helpers.asset_url("house.png")
      }
    end
  end
end
