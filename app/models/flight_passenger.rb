class FlightPassenger < ApplicationRecord
  belongs_to :flight
  belongs_to :passenger

  def self.find_by_data(passenger_id, flight_id)
    where(passenger_id: passenger_id, flight_id: flight_id).first
  end
end
