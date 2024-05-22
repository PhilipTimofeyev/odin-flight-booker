class BookingsController < ApplicationController
	def new
		# @booking = Booking.new(booking_params)
		@booking = Booking.new
		@flight = Flight.all.find(booking_params[:flight_id])
		@num_of_passengers = booking_params[:num_of_passengers]
	end
end




private

def booking_params
	params.require(:booking).permit(:flight_id, :num_of_passengers)
end
