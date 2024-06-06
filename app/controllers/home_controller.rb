class HomeController < ApplicationController

	def index
	end

	def new
	# 	# date = date_params[:date]
	# 	# Rails.cache.write("flight_date", date)
	# 	# flights = Flight.get_flights(date)
	# 	# Flight.add_flights_to_db(flights, date)
	# 	# debugger	
		# @home = Flight.new
	end

	def create
		flights = Flight.get_flights(flight_date)
		Flight.add_flights_to_db(flights, date_params[:date])

		redirect_to "/flights/index"
	end


end
