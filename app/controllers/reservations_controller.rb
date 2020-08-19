require 'json'
require 'rest-client'

class ReservationsController < ApplicationController
  def index
    @upcoming_reservations = Reservation.where(user: current_user, past: false)
    @past_reservations = Reservation.where(user: current_user, past: true)
  end

  def show
    @reservation = Reservation.find(params[:id])
    @message = Message.new reservation: @reservation
    @articles = @reservation.hotel.articles
  end

  def edit
    @reservation = Reservation.find(params[:id])
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

  def new
    @reservation = Reservation.new
  end

  def create
    booking = find_booking
    render :new unless !booking.nil? && booking["firstNight"] == params[:reservation][:check_in_date]

    create_reservation_with_attributes(booking)
    find_room(booking)
    find_user(booking)
    @reservation.hotel = Hotel.first

    @reservation.save ? (redirect_to edit_reservation_path(@reservation)) : (render :new)
  end

  private

  def create_reservation_with_attributes(booking)
    @reservation = Reservation.new(
      check_in_date: Date.parse(booking['firstNight']),
      check_out_date: Date.parse(booking['lastNight']) + 1.day,
      channel: booking['referer'],
      reservation_number: booking['referer'] == 'direct' ? booking['bookId'] : booking['apiReference'],
      number_of_guests: booking['numAdult'].to_i + booking['numChild'].to_i
    )
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

  def find_room(booking)
    floors = %w[10 9 8 7 6 5 4 3 2]
    rooms = {"254974" => '1', "254975" => '2', "254976" => '3'}
    if booking["roomId"] == '254977'
      @reservation.room_number = 101
    else
      floor = floors[booking["unitId"].to_i - 1]
      room = rooms[booking["roomId"]]
      @reservation.room_number = "#{floor}0#{room}".to_i
    end
  end

  def find_booking
    bookings_json = request_api("https://www.beds24.com/api/json/getBookings")
    booking = bookings_json.find do |b|
      if b['referer'] == 'direct'
        b['bookId'] == params[:reservation][:reservation_number]
      else
        b["apiReference"] == params[:reservation][:reservation_number]
      end
    end
    booking
  end

  def find_user(booking)
    current_user.first_name = booking['guestFirstName']
    current_user.last_name = booking['guestName']
    current_user.save
    @reservation.user = current_user
  end

  def reservation_params
    params.require(:reservation).permit(
      :user_id, :hotel_id, :check_in_date, :check_out_date, :arrival_time, :departure_time,
      :reservation_number, :number_of_guests, :purpose, :channel, :room_number, :past
    )
  end
end
