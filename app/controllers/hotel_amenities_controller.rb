class HotelAmenitiesController < ApplicationController
  def index
    @reservation = Reservation.find(params[:reservation_id])
    @hotel_amenities = @reservation.hotel.hotel_amenities
    @hotel_amenities = @hotel_amenities.includes(:amenity).where(amenities: { category: params[:category] })
    @request = Request.new
  end
end
