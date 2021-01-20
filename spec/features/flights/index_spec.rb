require 'rails_helper'

RSpec.describe 'flight index page' do
  describe 'when I visit the page' do
    before :each do
      @airline = Airline.create!(name: 'Turing Airways')

      @flight1 = Flight.create!(airline_id: @airline.id, number: '1776', departure_city: "Denver", arrival_city: 'McAllen', date: '21JAN21')
      @flight2 = Flight.create!(airline_id: @airline.id, number: '1789', departure_city: "McAllen", arrival_city: 'Pittsburgh', date: '21JFEB21')

      @passenger1 = Passenger.create!(name: 'Donald Trump', age: 73)
      @passenger2 = Passenger.create!(name: 'Joe Biden', age: 78)
      @passenger3 = Passenger.create!(name: 'Kamala (Momala) Harris', age: 50)

      FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger1.id)
      FlightPassenger.create!(flight_id: @flight1.id, passenger_id: @passenger2.id)
      FlightPassenger.create!(flight_id: @flight2.id, passenger_id: @passenger3.id)

      visit flights_path
    end

    it 'shows a list of all flight numbers' do
      expect(page).to have_content(@flight1.number)
      expect(page).to have_content(@flight2.number)
    end

    it 'shows all passengers for each flight' do
      within("#flight-#{@flight1.id}") do
        expect(page).to have_content(@passenger1.name)
        expect(page).to have_content(@passenger2.name)
      end

      within("#flight-#{@flight2.id}") do
        expect(page).to have_content(@passenger3.name)
      end
    end

    describe 'it can delete a passenger from a flight' do
      it 'has a delete button next to passengers' do

        within("#flight-#{@flight1.id}") do
          expect(page).to have_link("Delete #{@passenger1.name} from this flight.")
          expect(page).to have_link("Delete #{@passenger2.name} from this flight.")
        end
      end

      it 'clicking the delete link takes me back to the index page' do
        within("#flight-#{@flight1.id}") do
          click_link "Delete #{@passenger1.name} from this flight."
        end

        expect(current_path).to eq(flights_path)
      end

      it 'removes that passenger name from the flight' do

        within("#flight-#{@flight1.id}") do
          click_link "Delete #{@passenger1.name} from this flight."
        end

        expect(page).not_to have_content(@passenger1.name)
      end
    end
  end
end
