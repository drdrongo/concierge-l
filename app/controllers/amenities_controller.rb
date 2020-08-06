class AmenitiesController < ApplicationController
  def index
    @reservation = Reservation.find(params[:reservation_id])
    @amenities = @reservation.hotel.amenities
  end
end
