class ReservationChannel < ApplicationCable::Channel
  def subscribed
    # Explanation: The subscribed method gets called once a subscription to the channel is established
    # and it is responsible to setup the stream from which data will be sent back and forth.
    reservation = Reservation.find params[:reservation]
    stream_for reservation
    raise
    # or  
    # stream_from "room_#{params[:room]}"
  end
end
