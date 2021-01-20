require 'rails_helper'

RSpec.describe 'airline show page' do
  describe 'when I visit an airline show page' do
    it 'shows a list of passengers unique to that airline' do
      @airline1 = Airline.create!(name: 'Turing Airways')
      @airline2 = Airline.create!(name: 'ClaudeShannon Air')

      @flight1 = Flight.create!(airline_id: @airline1.id, number: '1776', departure_city: "Denver", arrival_city: 'McAllen', date: '21JAN21')
      @flight2 = Flight.create!(airline_id: @airline1.id, number: '1789', departure_city: "McAllen", arrival_city: 'Pittsburgh', date: '21JFEB21')
      @flight3 = Flight.create!(airline_id: @airline2.id, number: '1880', departure_city: "Los Angeles", arrival_city: 'Detroit', date: '18MAR21')
      @flight4 = Flight.create!(airline_id: @airline2.id, number: '1669', departure_city: "Bangor", arrival_city: 'New York', date: '16APR21')

      @passenger1 = Passenger.create!(name: 'Donald Trump', age: 73)
      @passenger2 = Passenger.create!(name: 'Joe Biden', age: 78)
      @passenger3 = Passenger.create!(name: 'Kamala (Momala) Harris', age: 50)
      @passenger4 = Passenger.create!(name: 'Sensei Tyrell', age: 32)
      @passenger5 = Passenger.create!(name: 'Codemaster Zanti', age: 34)
      @passenger6 = Passenger.create!(name: 'Coder Heath', age: 34)

      FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger1.id)
      FlightPassenger.create!(flight_id: @flight2.id, passenger_id: @passenger1.id)
      FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger2.id)
      FlightPassenger.create!(flight_id: @flight2.id, passenger_id: @passenger3.id)
      FlightPassenger.create!(flight_id: @flight3.id, passenger_id: @passenger4.id)
      FlightPassenger.create!(flight_id: @flight3.id, passenger_id: @passenger5.id)
      FlightPassenger.create!(flight_id: @flight4.id, passenger_id: @passenger6.id)

      visit airline_path(@airline1)

      expect(page).to have_content(@passenger1.name)
      expect(page).to have_content(@passenger2.name)
      expect(page).to have_content(@passenger3.name)

      expect(page).not_to have_content(@passenger4.name)
    end
  end
end
