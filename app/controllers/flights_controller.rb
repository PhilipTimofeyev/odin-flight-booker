class FlightsController < ApplicationController
	helper_method :create

	def show
		# debugger
		@flights = Flight.where(flight_params.except(:num_of_passengers))
		@num_of_passengers = flight_params[:num_of_passengers].to_i
		# debugger
	end

	def new
		#calls method to call API if only dates param is submitted
		create if flight_params.keys.count == 1

		@flight = Flight.new(flight_params.except(:num_of_passengers))
	end


	def create
		flight_date = flight_params[:date]

			unless Flight.all.exists?(date: flight_date)
				flights = Flight.get_flights(flight_date)
				Flight.create_flights(flights, flight_date)
			end

	end

	private

  def flight_params
		params.fetch(:flight, {}).permit(:date, :departure_airport_id, :arrival_airport_id, :num_of_passengers)
  end

  def passenger_params
  	params.permit(:num_of_passengers)
  end

end
