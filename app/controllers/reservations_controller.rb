class ReservationsController < ApplicationController
  def index
    # @reservations = Reservation.where(user: current_user)
    @upcoming_reservations = Reservation.where(user: current_user, past: false)
    @past_reservations = Reservation.where(user: current_user, past: true)
  end

  def show
    @reservation = Reservation.find(params[:id])
    @articles = @reservation.hotel.articles
  end

  def new
    @reservation = Reservation.new
  end

end
