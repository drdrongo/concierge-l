class HotelAmenitiesController < ApplicationController
  def index
    @reservation = Reservation.find(params[:reservation_id])
    @request = Request.new

    @hotel_amenities = @reservation.hotel.hotel_amenities.includes(:amenity)
    @requestables = @hotel_amenities.where(hotel_amenities: { requestable: true })

    @hotel_amenities = @hotel_amenities.where(hotel_amenities: { requestable: false })

    @essentials = @hotel_amenities.where(amenities: { category: 'Essentials' })
    @bed_bath = @hotel_amenities.where(amenities: { category: 'Bed & Bath' })
    @kitchen = @hotel_amenities.where(amenities: { category: 'Kitchen' })
    @other = @hotel_amenities.where(amenities: { category: 'Other' })

    # @hotel_amenities = @hotel_amenities.includes(:amenity).where(amenities: { category: params[:category]}, hotel_amenities: { requestable: false })
  end
end
