require 'json'
require 'rest-client'

class ReservationsController < ApplicationController
  def index
    @upcoming_reservations = Reservation.where(user: current_user, past: false)
    @past_reservations = Reservation.where(user: current_user, past: true)
  end

  def show
    @bookings = request_api("https://www.beds24.com/api/json/getBookings")
    # @booking = json.key("908914960")
    @booking = @bookings.find { |booking| booking["apiReference"] == '915566853' }
    # @booking = @bookings[0..2]

    @reservation = Reservation.find(params[:id])
    @articles = @reservation.hotel.articles
  end

  def new
    @reservation = Reservation.new
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
end
