class FlightsController < ApplicationController

	def index

		if params[:date].present?
			get_all_flights
			get_airports

			# debugger
		end

		if params[:flight].present?
			# debugger
			@flights = get_date_flights
			@num_of_passengers = passenger_num_params[:num_of_passengers]
			debugger
		end

	end

	def get_all_flights
		# debugger
		flight_date = date_params[:date]
		Rails.cache.write("flight_date", flight_date)

		unless Flight.all.exists?(date: flight_date)
			flight_date_start = convert_to_unix(flight_date)
			flight_date_end = (Date.parse(flight_date).to_time + 2.hours).to_i

			response = RestClient.get("https://opensky-network.org/api/flights/all?begin=#{flight_date_start}&end=#{flight_date_end}")
			@json = JSON.parse(response).uniq

			add_airports
			add_flights
		end
	end

	def get_airports
		airports = Airport.all.map {|airport| airport.code}.sort

		@airport_depart = airports
		@airport_arrive = airports
	end

	def get_date_flights
		req_arrival_airport = search_params[:arrival_airport]
		req_departure_airport = search_params[:departure_airport]

		date = Rails.cache.read("flight_date")
		date_flights = Flight.where(date: date)
		# date_flights.select {|flight| flight.arrival_airport == arrival_airport && flight.departure_airport == departure_airport}
		date_flights.where(arrival_airport: req_arrival_airport, departure_airport: req_departure_airport)
	end

	def add_airports
		@json.each do |flight| 
			unless Airport.all.exists?(code: flight['estDepartureAirport'])
				Airport.create(code: flight['estDepartureAirport']) unless (flight['estDepartureAirport']).nil?
			end
		end
	end

	def add_flights
		@json.each do |flight| 
			unless Flight.all.exists?(icao_id: flight["icao24"])
				Flight.create(icao_id: flight['icao24'], departure_airport_id: flight["estDepartureAirport"], arrival_airport_id: flight["estArrivalAirport"], date: date_params[:date])
			end
		end
	end

	def convert_to_unix(date)
		Date.parse(date).to_time.to_i
	end

	private

	def search_params
		params.require(:flight).permit(:departure_airport, :arrival_airport)
	end

	def passenger_num_params
		params.require(:flight).permit(:num_of_passengers)
	end

	def date_params
		params.require(:date).permit(:date)
	end

	def filter_empty_params
		search_params.reject{ |_, v| v.empty? }
	end
end
