class TicketsController < ApplicationController

  def create
    @ticket = Ticket.new(ticket_params)
    @event = Event.find(params[:event_id])
    @ticket.user = current_user
    @ticket.event = @event
    if @ticket.save
      redirect_to event_path(@event)
    else
      render "events/show"
    end
  end

  def update
    @ticket = Ticket.find(params[:id])

    @ticket.update(ticket_params)
    redirect_back fallback_location: event_path(@ticket.event)
  end

  private

  def ticket_params
    params.require(:ticket).permit(:status)
  end
end
