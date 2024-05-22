class BookingsController < ApplicationController
	def new
		@booking = Booking.new
		@num_of_passengers = flight_params[:num_of_passengers].to_i

		@num_of_passengers.times do
			@booking.passengers.build
		end

		@seleced_flight = Flight.all.find(flight_params[:flight_id])
	end

	def create
		selected_flight = Flight.all.find(flight_params[:flight_id])

		booking = Booking.new(booking_params)
		booking.flight=selected_flight

		if booking.save
			redirect_to bookings_path
		end
	end

	private

	def flight_params
		params.require(:flight).permit(:flight_id, :num_of_passengers)
	end

	def booking_params
		params.require(:booking).permit(passengers_attributes: [:name, :email])
	end

end
