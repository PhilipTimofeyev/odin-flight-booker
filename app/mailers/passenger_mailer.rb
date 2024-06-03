class PassengerMailer < ApplicationMailer
	default from: 'notifications@example.com'

	def welcome_email
	  @passenger = params[:passenger]
	  debugger
	  @url  = 'http://example.com/login'
	  mail(to: @passenger.email, subject: 'Welcome to My Awesome Site')
	end
end
