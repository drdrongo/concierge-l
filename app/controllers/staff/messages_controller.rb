class Staff::MessagesController < ApplicationController
  def create
    @reservation = Reservation.find(params[:reservation_id])
    @message = Message.create(
      reservation: @reservation,
      user: current_user,
      content: message_params[:content]
    )
  end

  def message_params 
    params.require(:message).permit(:content)
  end
end
