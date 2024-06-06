class Flight < ApplicationRecord
	belongs_to :departure_airport, primary_key: :code, class_name: "Airport", optional: true
	belongs_to :arrival_airport, primary_key: :code, class_name: "Airport", optional: true
	has_many :bookings
	has_many :passengers, through: :bookings

	validates_length_of :departure_airport, :minimum => 0, :allow_nil => false
	validates_length_of :arrival_airport, :minimum => 0, :allow_nil => false

	def self.get_flights(flight_date)
		unless Flight.all.exists?(flight_date)
			all_flights_json = Opensky.new(flight_date).call
		end
	end

	def self.add_flights_to_db(flights, date)
		flights.each do |flight| 
			unless Flight.all.exists?(icao_id: flight["icao24"])
				Flight.create(icao_id: flight['icao24'], 
											departure_airport_id: flight["estDepartureAirport"], 
											arrival_airport_id: flight["estArrivalAirport"], 
											date: date)
			end
		end
	end
end
