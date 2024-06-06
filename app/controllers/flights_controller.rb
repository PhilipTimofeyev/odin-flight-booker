class FlightsController < ApplicationController

	def index
		if params[:date].present?
			date = date_params[:date]
			# Rails.cache.write("flight_date", date)
			# flights = Flight.get_flights(date)
			# Flight.add_flights_to_db(flights, date)
		end

		if params[:flight].present?
			@flights = get_date_flights
			@num_of_passengers = passenger_num_params[:num_of_passengers]
		end
	end

	def new
		@flight = Flight.new
	end

	def create
		
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
