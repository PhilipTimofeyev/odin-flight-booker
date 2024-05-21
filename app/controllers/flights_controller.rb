class FlightsController < ApplicationController

	def index
		@airport_options = Airport.all.map { |f| [f.code, f.id] }
		@start_date = Flight.all.map { |f| [f.start.strftime("%m-%d-%Y %H:%M %p"), f.id] }
	end
end
