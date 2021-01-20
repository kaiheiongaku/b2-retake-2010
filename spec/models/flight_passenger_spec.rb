require 'rails_helper'

RSpec.describe FlightPassenger, type: :model do
  describe 'relationships' do
    it { should belong_to :flight }
    it { should belong_to :passenger }
  end

  describe 'class methods' do
    before :each do
      @airline = Airline.create!(name: 'Turing Airways')

      @flight1 = Flight.create!(airline_id: @airline.id, number: '1776', departure_city: "Denver", arrival_city: 'McAllen', date: '21JAN21')

      @passenger1 = Passenger.create!(name: 'Donald Trump', age: 73)
      @passenger2 = Passenger.create!(name: 'Joe Biden', age: 78)

      @fp1 = FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger1.id)
      @fp2 = FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger2.id)
    end

    it 'finds flight passenger with flight and passenger ids' do

      expect(FlightPassenger.find_by_data(@passenger1.id, @flight1.id)).to eq(@fp1)
    end
  end
end
