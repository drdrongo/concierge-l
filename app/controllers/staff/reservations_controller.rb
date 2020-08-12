class Staff::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.order(updated_at: :DESC)

    @reservations_with_event = @reservations.map do |reservation|
      latest_event = [
        reservation.messages.order(updated_at: :DESC).limit(1).first,
        reservation.requests.order(updated_at: :DESC).limit(1).first,
        reservation.time_requests.order(updated_at: :DESC).limit(1).first
      ].compact.max_by(&:updated_at)
      [reservation, latest_event]
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    @message = Message.new reservation: @reservation
    requests = Request.where(reservation: @reservation)
    @all_requests = TimeRequest.where(reservation: @reservation) + requests
    @messages = Message.where(reservation: @reservation)
  end
end


