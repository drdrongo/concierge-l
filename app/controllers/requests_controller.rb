class RequestsController < ApplicationController
  def create
    @reservation = Reservation.find(params[:id])
    @request = Request.new(
      reservation_id: @reservation.id,
      amenity_id: params[:amenity]
    )

    if @request.save
      redirect_to reservation_path(@reservation)
    else
    end
  end
end
