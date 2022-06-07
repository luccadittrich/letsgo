class EventsController < ApplicationController
  before_action :set_user, only: %i[new create]
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @event = Event.last
  end
end
