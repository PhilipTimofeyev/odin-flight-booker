class FlightsController < ApplicationController

	def index
		# @flights = Flight.all
		@airport_options = Airport.all.map { |f| [f.code, f.id] }
		@flight_date = Flight.all.map { |f| [f.date, f.date] }.uniq

		if params[:commit]
			@flights = Flight.where(filter_empty_params).to_a
			@passengers = passenger_num_params
		end
	end

	private

	def search_params
		params.require(:flight).permit(:departure_airport, :arrival_airport, :date)
	end

	def passenger_num_params
		params.require(:flight).permit(:num_of_passengers)
	end

	def filter_empty_params
		search_params.reject{ |_, v| v.empty? }
	end
end
