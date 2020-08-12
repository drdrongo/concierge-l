class MessagesController < ApplicationController
  def create
    @reservation = Reservation.find(params[:reservation_id])
    @message = Message.new(message_params)
    @message.reservation = @reservation
    @message.user = current_user
    if @message.save
      redirect_to reservation_path(@reservation, anchor: "message-#{@message.id}")
    else
      render "reservations/show"
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
