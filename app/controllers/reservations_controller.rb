class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.where(user: current_user)
  end

  def show
    @reservation = Reservation.find(params[:id])
    @articles = @reservation.hotel.articles
  end

  def new
    @reservation = Reservation.new
  end

end
