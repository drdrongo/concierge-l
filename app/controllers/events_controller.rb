class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @events = Event.order(created_at: :desc)
  end

  def show
    @ticket = Ticket.new
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def edit
  end

  def update

    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :datetime, :venue, :capacity, :category, :user, :end_time, :photo)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
