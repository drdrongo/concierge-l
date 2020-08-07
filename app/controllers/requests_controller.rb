class RequestsController < ApplicationController
  def create
    reservation = Reservation.find(params[:reservation_id])
    @request = Request.new(
      reservation: reservation,
      hotel_amenity: HotelAmenity.find(params[:hotel_amenity_id])
    )
    if @request.save
      flash[:success] = "Post submitted!"
      redirect_to reservation_hotel_amenities_path(reservation)
    end

    # if @request.save
    #   redirect_to reservation_amenities_path(reservation)      
    # end
  end
end
