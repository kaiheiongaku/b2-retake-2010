class FlightsController < ApplicationController
  def index
    @flights = Flight.all
  end

  def destroy
    @passenger = Passenger.find(params[:passenger_id])
    @flight = Flight.find(params[:flight_id])
    @flight_passenger = FlightPassenger.find_by_data(@passenger.id, @flight.id)
    @flight_passenger.destroy
    redirect_to flights_path
  end
end
