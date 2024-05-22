class BookingsController < ApplicationController
	def new
		@booking = Booking.new

		@seleced_flight = Flight.all.find(flight_params[:flight_id])
		@num_of_passengers = flight_params[:num_of_passengers]
	end

	def create
		passenger = Passenger.new(booking_params)
		@new_booking = passenger.create_booking
		selected_flight = Flight.all.find(flight_params[:flight_id])
		@new_booking.flight=selected_flight
		debugger
	end

	private

	def flight_params
		params.require(:flight).permit(:flight_id, :num_of_passengers)
	end

	def booking_params
		params.require(:booking).permit(:name, :email)
	end

end
