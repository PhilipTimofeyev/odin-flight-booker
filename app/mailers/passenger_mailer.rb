class PassengerMailer < ApplicationMailer
	default from: 'onewayvacation@happy.com'

	def booking_email
	  @passenger = params[:passenger]
	  # debugger
	  mail(to: @passenger.email, subject: "You're booked!")
	end
end
