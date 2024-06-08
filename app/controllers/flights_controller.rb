class FlightsController < ApplicationController

	def show
		date = Rails.cache.read("flight_date")

		@airport_depart = Airport.joins(:departing_flights).where({departing_flights: {date: date}}).map {|airport| airport.code }.uniq.sort
		# @airport_arrive = Airport.joins(:arriving_flights).where({arriving_flights: {date: date}}).map {|airport| airport.code }.uniq.sort
		@airport_arrive = ""

		if params["dep_airport"].present?
			@airport_arrive = Airport.joins(:arriving_flights).where({arriving_flights: {date: date, departure_airport: params[:dep_airport]}}).map {|airport| airport.code }.uniq.sort
			# debugger
		end
	end

	# def index
	# 	date = Rails.cache.read("flight_date")
	# 	if params["dep_airport"].present?
	# 		@airport_arrive = Airport.joins(:arriving_flights).where({arriving_flights: {date: date, departure_airport: params[:dep_airport]}}).map {|airport| airport.code }.uniq.sort
	# 		# debugger
	# 	end

	# end

	def index
		
	end

	def create
		# debugger
		flight_date = date_params[:date]
		Rails.cache.write("flight_date", flight_date)

		flights = Flight.get_flights(flight_date)

		Flight.add_flights_to_db(flights, flight_date)

		redirect_to "/flights/show"
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
