class CheckInsController < ApplicationController
  def index
    @check_ins = CheckIn.all
  end

  def create
    @event = Event.find(params[:event_id])
    @check_in = CheckIn.new(event: @event, user: current_user)
    @check_in.confirmed = true
    @check_in.save

    redirect_to event_path(@event), notice: "você confirmou presença em #{@event.name}"
  end

  def confirm
    @event = Event.find(params[:event_id])
    @check_in = CheckIn.new(event: @event, user: current_user)

    @check_in.confirmed = true
  end

  def destroy
  end




end
