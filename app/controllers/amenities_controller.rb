class AmenitiesController < ApplicationController
  def index
    reservation = Reservation.find(params[:reservation_id])
    @amenities = reservation.hotel.amenities
    @request = Request.new
  end

  # def create
  #   reservation = Reservation.find(params[:reservation_id])
  #   @request = Request.new(
  #     reservation: reservation,
  #     user: current_user
  #   )
  #   if @request.save
  #     render :index
  #   end
  # end
end
