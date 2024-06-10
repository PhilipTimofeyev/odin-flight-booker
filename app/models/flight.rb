class Flight < ApplicationRecord
	belongs_to :departure_airport, primary_key: :code, class_name: "Airport", optional: true
	belongs_to :arrival_airport, primary_key: :code, class_name: "Airport", optional: true
	has_many :bookings
	has_many :passengers, through: :bookings

	validates_length_of :departure_airport, :minimum => 4, :allow_nil => false
	validates_length_of :arrival_airport, :minimum => 4, :allow_nil => false
	validates :icao_id, uniqueness: true

	def self.get_flights(flight_date)
		# unless Flight.all.exists?(date: flight_date)
			Opensky.new(flight_date).call
		# end
	end

	def self.create_flights(flights, date)
		# return Flight.where(date: date) unless flights
		flights.each do |flight| 
			Flight.create(icao_id: flight['icao24'], 
										departure_airport_id: flight["estDepartureAirport"], 
										arrival_airport_id: flight["estArrivalAirport"], 
										date: date)
			end
	end
end
