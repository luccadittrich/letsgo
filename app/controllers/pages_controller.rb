class PagesController < ApplicationController
  def home
    @widget = 'home'
    @sidebar = 'home'
    @feed_header = 'home'
    @events = Event.all
    @check_ins = CheckIn.where(user_id: current_user)
    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        image_url: helpers.asset_url("marker.jpg")
      }
    end

    @markers << {
      lat: current_user.latitude,
      lng: current_user.longitude,
      image_url: helpers.asset_url("bluemarker.png")
    }
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
