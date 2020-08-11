class Staff::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.joins(:messages)
    @reservations += Reservation.joins(:requests)
    @reservations += Reservation.joins(:time_requests)
    @reservations = @reservations.sort_by(&:updated_at).reverse.uniq
  end

  def show
    @reservation = Reservation.find(params[:id])
    requests = Request.where(reservation: @reservation)
    @all_requests = TimeRequest.where(reservation: @reservation).merge(requests)
    raise
  end
end
