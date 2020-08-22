require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper

class MessagesController < ApplicationController
  def create
    @reservation = Reservation.find(params[:reservation_id])
    @message = Message.create user: current_user,
                              reservation: @reservation,
                              content: message_params[:content]
    ReservationChannel.broadcast_to @reservation, { message: @message, author: @message.user, time_ago: time_ago_in_words(@message.created_at) }
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
