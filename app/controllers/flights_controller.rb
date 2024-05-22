class FlightsController < ApplicationController

	def index
		@airport_options = Airport.all.map { |f| [f.code, f.id] }
		@flight_date = Flight.all.map { |f| [f.date, f.date] }.uniq

		if search_params.present?
			@flights = Flight.where(filter_empty_params).to_a
			@hmm = params[:date]
		end
	end

	private
	def search_params

		params.permit(:departure_airport, :arrival_airport, :date)
	end

	def filter_empty_params
		search_params.reject{ |_, v| v.empty? }
	end
end
