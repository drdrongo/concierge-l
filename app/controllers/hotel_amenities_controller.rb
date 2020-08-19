class HotelAmenitiesController < ApplicationController
  def index
    @reservation = Reservation.find(params[:reservation_id])
    @back_path = {controller: "reservations", action: "show", id: @reservation.id}

    @hotel_amenities = @reservation.hotel.hotel_amenities.includes(:amenity)
    
    @requestables = @hotel_amenities.where(hotel_amenities: { requestable: true })
    @essentials = @hotel_amenities.where(amenities: { category: 'Essentials' }, hotel_amenities: { requestable: false })
    @bed_bath = @hotel_amenities.where(amenities: { category: 'Bed & Bath' }, hotel_amenities: { requestable: false })
    @kitchen = @hotel_amenities.where(amenities: { category: 'Kitchen' }, hotel_amenities: { requestable: false })
    @other = @hotel_amenities.where(amenities: { category: 'Other' }, hotel_amenities: { requestable: false })


    @hotel_amenities = @hotel_amenities.includes(:amenity).where(amenities: { category: params[:category]}, hotel_amenities: { requestable: false })
    
    @request = Request.new
  end
end
