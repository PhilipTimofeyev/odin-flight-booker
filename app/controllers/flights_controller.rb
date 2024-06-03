class FlightsController < ApplicationController

	OPTIONS = [ "RCTP",
						 "SAEZ",
						 "EDDF",
						 "EGSH",
						 "EGCC",
						 "LIMC",
						 "LGAV",
						 "EHAM",
						 "EDDL",
						 "EDDH",
						 "LDZA",
						 "LJLJ",
						 "ENGK",
						 "LTFM",
						 "LIRF",
						 "RJTT",]

	def index
		# @airport_options = Airport.all.map { |f| [f.code, f.id] }
		# @airport_options = OPTIONS
		@flight_date = Flight.all.map { |f| [f.date, f.date] }.uniq

		if params[:date].present?
			# @passengers = passenger_num_params

			get_airport
			# get_airport_non_api

			# debugger

		end

		def get_airport_non_api
			@airport_depart = OPTIONS
			@airport_arrive = OPTIONS
		end

		def get_airports
			flight_date = date_params[:date]
			flight_date_start = convert_to_unix(flight_date)
			flight_date_end = (Date.parse(flight_date).to_time + 2.hours).to_i

			response = RestClient.get("https://opensky-network.org/api/flights/all?begin=#{flight_date_start}&end=#{flight_date_end}")
			result = JSON.parse(response)

			@airport_depart = result.map {|hsh| hsh["estDepartureAirport"]}.compact.uniq.sort
			@airport_arrive = result.map {|hsh| hsh["estArrivalAirport"]}.compact.uniq.sort
		end

		def convert_to_unix(date)
			Date.parse(date).to_time.to_i
		end
	end

	private

	def search_params
		params.require(:flight).permit(:departure_airport, :arrival_airport, :date)
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
