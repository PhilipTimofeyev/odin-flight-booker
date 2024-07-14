class BookingsController < ApplicationController
	def new
		@booking = Booking.new
		@num_of_passengers = booking_params[:num_of_passengers].to_i

		@num_of_passengers.times do
			@booking.passengers.build
		end

		@selected_flight = Flight.where(icao_id: booking_params[:icao_id]).first || Rails.cache.read("selected_flight") 
		Rails.cache.write("selected_flight", @selected_flight)
		Rails.cache.write("num_of_passengers", @num_of_passengers)
	end

	def create
		@selected_flight = Rails.cache.read("selected_flight") 
		@num_of_passengers = Rails.cache.read("num_of_passengers") 
		@booking = Booking.new(better_params)

		if @booking.save
			@booking.passengers.each do |passenger|
				PassengerMailer.with(passenger: passenger).booking_email.deliver_later
			end
			redirect_to @booking
		else
			render :new, status: :unprocessable_entity
		end
	end

	def show
		@booking = Booking.find(params[:id])
		@selected_flight = @booking.flight
		@passengers = @booking.passengers
		@num_of_passengers = @booking.passengers.count
	end

	private

	def booking_params
		params.require(:booking).permit(:icao_id, :num_of_passengers, passengers_attributes: [:name, :email])
	end

	def better_params
		params.require(:booking).permit(:flight_id, :num_of_passengers, passengers_attributes: [:name, :email])
	end

end
