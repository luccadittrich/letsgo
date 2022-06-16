class CheckInsController < ApplicationController
  def index
    @check_ins = CheckIn.all
  end

  def create
    @event = Event.find(params[:event_id])
    @check_in = CheckIn.new(event: @event, user: current_user)
    @check_in.confirmed = true
    @check_in.save
    current_user.followers.select {|user| user.events.exists?(id:@event.id)}.uniq.each do |notified_user|
      Notification.create(user: notified_user, content: "O usuário #{current_user.username} confirmou presença em #{@event.name}.")
    end
    redirect_to event_path(@event), notice: "você confirmou presença em #{@event.name}"
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
