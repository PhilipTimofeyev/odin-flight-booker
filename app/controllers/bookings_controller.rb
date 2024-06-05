class BookingsController < ApplicationController
	def new
		@booking = Booking.new
		@num_of_passengers = booking_params[:num_of_passengers].to_i

		@num_of_passengers.times do
			@booking.passengers.build
		end

		@selected_flight = Flight.where(icao_id: booking_params[:icao_id]).first
	end

	def create
		selected_flight = Flight.where(icao_id:params[:booking][:flight_id])

		@booking = Booking.new(better_params)
		# debugger

		if @booking.save
			@booking.passengers.each do |passenger|
				# debugger
				# PassengerMailer.with(passenger: passenger).booking_email.deliver_now
			end
			redirect_to @booking
		end
	end

	def show
		@booking = Booking.find(params[:id])
		@selected_flight = @booking.flight
		@passengers = @booking.passengers
	end

	private

	def booking_params
		params.require(:booking).permit(:icao_id, :num_of_passengers, passengers_attributes: [:name, :email])
	end

	def better_params
		params.require(:booking).permit(:flight_id, :num_of_passengers, passengers_attributes: [:name, :email])
	end

end
