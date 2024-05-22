class BookingsController < ApplicationController
	def new
		@booking = Booking.new(booking_params)
	end
end




private

def booking_params
	params.require(:flight).permit(:selected_flight)
end
