class MessagesController < ApplicationController
  def create
    @reservation = Reservation.find(params[:reservation_id])
    @message = Message.create user: current_user,
                              reservation: @reservation,
                              content: message_params[:content]
    ReservationChannel.broadcast_to @reservation, @message
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
