class TimeRequestsController < ApplicationController
  def create
    @reservation = Reservation.find(params[:reservation_id])
    @reservation.update(seen: false)
    prms = params
    if @reservation.arrival_time != prms[:arrival_time] && @reservation.departure_time != prms[:departure_time]
      create_arrival_request(@reservation, prms).save
      create_departure_request(@reservation, prms).save
    elsif @reservation.arrival_time != prms[:arrival_time]
      create_arrival_request(@reservation, prms).save
    elsif @reservation.departure_time != prms[:departure_time]
      create_departure_request(@reservation, prms).save
    end
    redirect_to reservation_path(@reservation)
  end

  def update
    @reservation = Reservation.find(params[:reservation_id])
    @time_request = TimeRequest.find(params[:id])
    @time_request.update(status: params[:time_request][:status])
    if params[:time_request][:reservation]
      update_reservation(@time_request, @reservation, params[:time_request][:reservation])
    end
    redirect_to staff_reservation_path(@reservation, anchor: "time-request-#{@time_request.id}")
  end

  private

  def update_reservation(request, reservation, prms)
    if request.check_in
      reservation.update(arrival_time: prms[:arrival_time])
    else
      reservation.update(departure_time: prms[:departure_time])
    end
  end

  def create_arrival_request(reservation, prms)
    Time.zone = "Etc/UTC"
    TimeRequest.new(
      check_in: true,
      reservation: reservation,
      time: Time.parse(prms[:arrival_time]).utc
    )
  end

  def create_departure_request(reservation, prms)
    Time.zone = "Etc/UTC"
    TimeRequest.new(
      check_in: false,
      reservation: reservation,
      time: Time.parse(prms[:departure_time]).utc
    )
  end
end
