class Staff::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.joins(:messages)
    @reservations += Reservation.joins(:requests)
    @reservations += Reservation.joins(:time_requests)
    @reservations = @reservations.sort_by(&:updated_at).reverse.uniq
  end
end
