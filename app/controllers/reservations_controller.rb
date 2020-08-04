class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.where(user: current_user)
    # @upcoming_reservations = Reservation.where(user: current_user, )
    # @past_reservations = Reservation.where(user: current_user, checkout_date: )
  end

  def show
    @reservation = Reservation.find(params[:id])
    @articles = @reservation.hotel.articles
  end
end
