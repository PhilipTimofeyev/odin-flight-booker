class BookingsController < ApplicationController
	def new
		@booking = Booking.new
		@num_of_passengers = flight_params[:num_of_passengers].to_i
		@num_of_passengers.times do
			@booking.passengers.build
		end
		# debugger


		@seleced_flight = Flight.all.find(flight_params[:flight_id])
	end

	def create
		# debugger
		# passenger = Passenger.new booking_params
		booking = Booking.create(booking_params)
		debugger
		# debugger
		# passenger = Passenger.new(booking_params)
		# @new_booking = passenger.create_booking
		# selected_flight = Flight.all.find(flight_params[:flight_id])
		# @new_booking.flight=selected_flight
		# debugger
	end

	private

	def flight_params
		params.require(:flight).permit(:flight_id, :num_of_passengers)
	end

	def booking_params
		params.require(:booking).permit(passengers_attributes: [:name, :email])
	end

end
