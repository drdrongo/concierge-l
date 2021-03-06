class Staff::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.order(updated_at: :DESC)

    @reservations_with_event = @reservations.includes(:user).map do |reservation|
      latest_event = [
        reservation.messages.order(updated_at: :DESC).limit(1).first,
        reservation.requests.order(updated_at: :DESC).limit(1).first,
        reservation.time_requests.order(updated_at: :DESC).limit(1).first
      ].compact.max_by(&:updated_at)
      [reservation, latest_event]
    end

    # Sorts events by whether they were seen or not. Unseen events become pink on the index page.
    @reservations_with_event.sort_by { |x| x[0].seen? ? 0 : 1 }

    # Old code for mmaybe sorting by updated_at on the latest_event, but didn't work when ALL latest_events were nil.
    # @reservations_with_event.sort_by { |_x, y| [y ? y[:updated_at] : 1000] }
  end

  def show
    @reservation = Reservation.find(params[:id])
    @message = Message.new reservation: @reservation

    # Gets all requests (amenity + time requests) and sorts them by created_at, descending.
    requests = Request.where(reservation: @reservation)
    @all_requests = (TimeRequest.where(reservation: @reservation) + requests).sort_by(&:created_at).reverse!
    @messages = Message.where(reservation: @reservation)
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.update(reservation_params)
    # This part here: I'm not sure how to handle this; do I need an if statement here? If so, what's needed?
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
