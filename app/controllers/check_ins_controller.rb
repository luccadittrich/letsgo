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
    # @check_in.each do |someone|
    # @check_in_all = CheckIn.new(event: @event, user: someone)
    @check_in.confirmed = true
  end

  def destroy
    @event = Event.find(params[:event_id])
    @check_in = CheckIn.find_by(event: @event, user: current_user)
    @check_in.confirmed = false
    @event.save
    @check_in.destroy
    redirect_to event_path(@event)
  end
end
