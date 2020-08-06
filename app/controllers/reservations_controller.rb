require 'json'
require 'rest-client'

class ReservationsController < ApplicationController
  def index
    @upcoming_reservations = Reservation.where(user: current_user, past: false)
    @past_reservations = Reservation.where(user: current_user, past: true)
  end

  def show
    @reservation = Reservation.find(params[:id])
    @articles = @reservation.hotel.articles
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.update(reservation_params)
    if @reservation.save
      redirect_to reservation_path(@reservation.id)
    else
      render :show
    end
  end

  def edit
    @reservation
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new
    bookings_json = request_api("https://www.beds24.com/api/json/getBookings")
    rsv_params = params["reservation"]

    booking = bookings_json.find { |b| b["apiReference"] == rsv_params["reservation_number"] }
    check_in_date = "#{rsv_params['check_in_date(1i)']}-#{rsv_params['check_in_date(2i)'].rjust(2, '0')}-#{rsv_params['check_in_date(3i)'].rjust(2, '0')}"

    if booking != nil && booking["firstNight"] == check_in_date
      @reservation = Reservation.new(
        check_in_date: Date.parse(booking['firstNight']),
        check_out_date: Date.parse(booking['lastNight']),
        reservation_number: booking['apiReference'],
        number_of_guests: booking['numAdult'].to_i + booking['numChild'].to_i,
        channel: booking['referer']
      )
      @reservation.user = current_user
      @reservation.hotel = Hotel.first

      redirect_to reservations_path if @reservation.save
    else
      flash[:notice] = 'Details incorrect. Please try again'
      render :new
    end
  end

  def request_api(url)
    payload = {
      "authentication": {
        "apiKey": "bropdQL9vXILFXr6Iwr1urG8m",
        "propKey": "xmyTyn0oIvRZG09yvwcQk1Zlj"
      },
      "includeInvoice": false,
      "includeInfoItems": false
    }
    response = RestClient.post(url, payload.to_json, content_type: :json)
    return JSON.parse(response)
  end

  private

  def sanitize_reservation
    params['reservation']['check_in_date'] = "#{params['reservation']['check_in_date(1i)']}-#{params['reservation']['check_in_date(2i)'].rjust(2, '0')}-#{params['reservation']['check_in_date(3i)'].rjust(2, '0')}"
  end

  def reservation_params
    params.require(:reservation).permit(
      :user_id, :hotel_id, :check_in_date, :check_out_date, :arrival_time, :departure_time,
      :reservation_number, :number_of_guests, :purpose, :channel, :room_number, :past
    )
  end
end
