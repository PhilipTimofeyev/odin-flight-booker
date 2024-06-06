class FlightsController < ApplicationController

	def index
		# CallOpenSkyAPI.new(flight_date)


		if params[:date].present?
			@json = get_all_flights
			# debugger
			get_airports
		end

		if params[:flight].present?
			@flights = get_date_flights
			@num_of_passengers = passenger_num_params[:num_of_passengers]
			# debugger
		end

	end

	def get_all_flights
		# debugger
		flight_date = date_params[:date]
		Rails.cache.write("flight_date", flight_date)

		unless Flight.all.exists?(date: flight_date)
			@json = Opensky.new(flight_date).call

			add_flights
			@json
		end
	end

	def get_airports
		date = Rails.cache.read("flight_date")

		#selects only airports with departing and arriving flights on that day
		@airport_depart = Airport.joins(:departing_flights).where({departing_flights: {date: date}}).map {|airport| airport.code }.uniq.sort
		@airport_arrive = Airport.joins(:arriving_flights).where({arriving_flights: {date: date}}).map {|airport| airport.code }.uniq.sort
	end

	def get_date_flights
		req_arrival_airport = filter_empty_params[:arrival_airport]
		req_departure_airport = filter_empty_params[:departure_airport]

		hsh = {arrival_airport: req_arrival_airport, departure_airport: req_departure_airport}.compact

		date = Rails.cache.read("flight_date")
		date_flights = Flight.where(date: date)
		
		date_flights.where(hsh)
	end

	def select_non_nil_flights
		non_nil_flights = @json.reject {|flight| flight["estDepartureAirport"].nil? || flight["estArrivalAirport"].nil? }
	end

	def add_flights
		select_non_nil_flights.each do |flight| 
			unless Flight.all.exists?(icao_id: flight["icao24"])
				Flight.create(icao_id: flight['icao24'], departure_airport_id: flight["estDepartureAirport"], arrival_airport_id: flight["estArrivalAirport"], date: date_params[:date])
			end
		end
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
