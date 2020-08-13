class TimeRequestsController < ApplicationController
  def create
    @reservation = Reservation.find(params[:reservation_id])
    prms = params[:time_request]
    @arrival_time_request = create_arrival_request(@reservation, prms)
    @departure_time_request = create_departure_request(@reservation, prms)

    if @reservation.arrival_time != prms[:arrival_time] && @reservation.departure_time != prms[:departure_time]
      if @arrival_time_request.save && @departure_time_request.save
        redirect_to reservation_path(@reservation)
      else
        puts "uh oh you didnt saveeeee!"
      end

    elsif @reservation.arrival_time != prms[:arrival_time]
      if @arrival_time_request.save
        redirect_to reservation_path(@reservation)
      else
        puts "uh oh you didnt saveeeee!"
      end

    elsif @reservation.departure_time != prms[:departure_time]
      if @departure_time_request.save
        redirect_to reservation_path(@reservation)
      else
        puts "uh oh you didnt saveeeee!"
      end

    else
      puts "Do nothing"
    end

    raise
  end

  private

  def create_arrival_request(reservation, prms)
    TimeRequest.new(
      check_in: true,
      reservation: reservation,
      time: prms[:arrival_time]
    )
  end

  def create_departure_request(reservation, prms)
    TimeRequest.new(
      check_in: false,
      reservation: reservation,
      time: prms[:departure_time]
    )
  end
end
