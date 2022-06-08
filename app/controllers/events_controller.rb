class EventsController < ApplicationController
  # before_action :set_user, only: %i[new create]
  # before_action :set_event, only: %i[show edit update destroy]

  def index
    if params[:query].present?
      @events = Event.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @events = Event.all.order(created_at: :desc)
    end
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

  def update
    @event = Event.new(event_params)

    if @event.update(event_params)
      redirect_to @event, notice: "#{@event.name} foi editado."
      @event.save
    else
      render :edit
    end
  end

  #   @event = Event.find(params[:id])
  #   @event.update([:id])
  #   if @event.update
  #     redirect_to @event, notice: "O item #{@event.name} foi editado."
  #   else
  #     render :edit
  #   end
  # end

  private

  def event_params
    params.require(:event).permit(:name, :date, :description, :local, :photo, :category, :private)
  end
end
