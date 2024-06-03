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
		# @flight_date = Flight.all.map { |f| [f.date, f.date] }.uniq

		if params[:date].present?
			# @passengers = passenger_num_params
			# Rails.cache.write("list",[1,2,3])

			# get_flights

			get_all_flights

			get_airports
			# get_airport_non_api

			# debugger
		end

		if params[:flight].present?
			# debugger
			@flights = get_date_flights
			@num_of_passengers = passenger_num_params[:num_of_passengers]
			# debugger
		end

	end

		def get_airport_non_api
			@airport_depart = OPTIONS
			@airport_arrive = OPTIONS
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
			@airport_depart = @json.map {|hsh| hsh["estDepartureAirport"]}.compact.uniq.sort
			@airport_arrive = @json.map {|hsh| hsh["estArrivalAirport"]}.compact.uniq.sort
		end

		def get_date_flights
			arrival_airport = search_params[:arrival_airport]
			departure_airport = search_params[:departure_airport]
			Rails.cache.read("json_flights").select {|flight| flight["estArrivalAirport"] == arrival_airport && flight["estDepartureAirport"] == departure_airport}

			# debugger
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
