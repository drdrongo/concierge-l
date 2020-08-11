class HotelAmenitiesController < ApplicationController
  def index
    @reservation = Reservation.find(params[:reservation_id])
    @hotel_amenities = @reservation.hotel.hotel_amenities
    @request = Request.new
  end
end
