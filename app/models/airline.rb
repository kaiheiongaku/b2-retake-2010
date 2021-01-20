class Airline < ApplicationRecord
  has_many :flights

  def unique_passengers
    Passenger.joins(flights: :flight_passengers).where('flights.airline_id = ?', self.id).distinct
  end
end
