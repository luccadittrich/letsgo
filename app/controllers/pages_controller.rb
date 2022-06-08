class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @events = Event.all.order(created_at: :desc)
    @events = Event.all

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        image_url: helpers.asset_url("marker.jpg")
      }
    end
  end
end
