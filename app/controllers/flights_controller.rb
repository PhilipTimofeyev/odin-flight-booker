class FlightsController < ApplicationController

	def index

		if params[:date].present?
			get_all_flights
			add_airports
			get_airports

			# debugger
		end

		if params[:flight].present?
			# debugger
			@flights = get_date_flights
			@num_of_passengers = passenger_num_params[:num_of_passengers]
			# debugger
		end

	end

	def get_all_flights
		# debugger
		flight_date = date_params[:date]
		flight_date_start = convert_to_unix(flight_date)
		flight_date_end = (Date.parse(flight_date).to_time + 2.hours).to_i

		# get_request = "https://opensky-network.org/api/flights/all?begin=#{flight_date_start}&end=#{flight_date_end}"

		response = RestClient.get("https://opensky-network.org/api/flights/all?begin=#{flight_date_start}&end=#{flight_date_end}")
		# response = RestClient.get("https://opensky-network.org/api/flights/all?begin=#{flight_date_start}&end=#{flight_date_end}")
		@json = JSON.parse(response).uniq

		Rails.cache.write("json_flights", @json)
	end

	def get_airports
		# departing = Airport.all
		@airport_depart = Airport.all.map {|airport| airport.code}.sort
		@airport_arrive = Airport.all.map {|airport| airport.code}.sort
	end

	def get_date_flights
		arrival_airport = search_params[:arrival_airport]
		departure_airport = search_params[:departure_airport]
		Rails.cache.read("json_flights").select {|flight| flight["estArrivalAirport"] == arrival_airport && flight["estDepartureAirport"] == departure_airport}

		# debugger
	end

	def add_airports
		@json.each do |flight| 
			unless Airport.all.exists?(code: flight['estDepartureAirport'])
				Airport.create(code: flight['estDepartureAirport']) unless (flight['estDepartureAirport']).nil?
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
