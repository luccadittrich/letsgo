class EventsController < ApplicationController
  # before_action :set_user, only: %i[new create]
  # before_action :set_event, only: %i[show edit update destroy]

  def index
    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    if params[:query].present?
      @events =fshow Event.search_by_name_and_category(params[:query])
    else
      @events = Event.all.order(created_at: :desc)
    end
    @check_ins = CheckIn.where(user_id: current_user)
    @sidebar = 'events'
    @feed_header = 'events'
    @widget = 'events'

    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        image_url: helpers.asset_url("house.png")
      }
    end
  end

  def show
    @event = Event.find(params[:id])
    @user = current_user
    @check_in = CheckIn.where(user: current_user)
    @markers = [{ lat: @event.latitude, lng: @event.longitude, image_url: helpers.asset_url("house.png") }]
    @post = Post.new
    @posts = @event.posts
    @feed_header = 'show'
    @widget = 'event'
  end

  # get pro form
  def new
    @event = Event.new
    @sidebar = 'new'
    @feed_header = 'new'
  end

  # post do form
  def create
    @event = Event.new(event_params)
    @user = current_user
    @event.user = @user

    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event, notice: "#{@event.name} foi editado."
      @event.save
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: "O evento #{@event.name} foi cancelado!"
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :description, :address, :photo, :category, :private)
  end
end
