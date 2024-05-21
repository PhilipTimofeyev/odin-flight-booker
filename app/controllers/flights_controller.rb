class FlightsController < ApplicationController

	def index

		@airport_options = Airport.all.map { |f| [f.code, f.id] }
		@start_date = Flight.all.map { |f| [f.start.strftime("%m-%d-%y at %H:%M %p"), f.start] }

		if search_params.present?
			@flights = Flight.where(departure_airport_id: params[:departure_airport], arrival_airport_id: params[:arrival_airport], start: params[:start]).to_a
		end
	end



	private
	def search_params
		params.permit(:departure_airport, :arrival_airport, :num_of_passengers, :start)
	end
end
