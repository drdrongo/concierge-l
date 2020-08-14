class Staff::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.order(updated_at: :DESC)

    @reservations_with_event = @reservations.map do |reservation|
      latest_event = [
        reservation.messages.order(updated_at: :DESC).limit(1).first,
        reservation.requests.order(updated_at: :DESC).limit(1).first,
        reservation.time_requests.order(updated_at: :DESC).limit(1).first
      ].compact.max_by(&:updated_at)
      [reservation, latest_event]
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    @message = Message.new reservation: @reservation

    requests = Request.where(reservation: @reservation)
    @all_requests = TimeRequest.where(reservation: @reservation) + requests
    @messages = Message.where(reservation: @reservation)
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.update(reservation_params)
    if @reservation.save
      redirect_to staff_reservation_path(@reservation.id)
    else
      render :show
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(
      :user_id, :hotel_id, :check_in_date, :check_out_date, :arrival_time, :departure_time,
      :reservation_number, :number_of_guests, :purpose, :channel, :room_number, :past
    )
  end
end
