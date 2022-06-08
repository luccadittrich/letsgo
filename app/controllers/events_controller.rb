class EventsController < ApplicationController
  # before_action :set_user, only: %i[new create]
  # before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = Event.all.order(created_at: :desc)
  end

  def show
    @event = Event.find(params[:id])
  end

  # get pro form
  def new
    @event = Event.new
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

  private

  def event_params
    params.require(:event).permit(:name, :date, :description, :address, :photo, :category, :private)
  end
end
