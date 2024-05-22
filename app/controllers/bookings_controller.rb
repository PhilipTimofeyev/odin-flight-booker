class BookingsController < ApplicationController
	def new
		@booking = Booking.new
		@num_of_passengers = booking_params[:num_of_passengers].to_i

		@num_of_passengers.times do
			@booking.passengers.build
		end

		@seleced_flight = Flight.all.find(booking_params[:flight_id])
	end

	def create
		selected_flight = Flight.all.find(booking_params[:flight_id])

		@booking = Booking.new(booking_params)

		if @booking.save
			redirect_to @booking
		end
	end

	def show
		@booking = Booking.find(params[:id])
		@seleced_flight = @booking.flight
		@passengers = @booking.passengers
	end

	private

	def booking_params
		params.require(:booking).permit(:flight_id, :num_of_passengers, passengers_attributes: [:name, :email])
	end

end
