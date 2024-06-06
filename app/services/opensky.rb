

	class Opensky
		#OpenSky API call requires 2 unix times within 2 hours of eachother.

		def initialize(date)
			@date = date
		end

		def call
			start_date = Date.parse(@date).to_time
			end_date = start_date + 2.hours

			response = RestClient.get("https://opensky-network.org/api/flights/all?begin=#{start_date.to_i}&end=#{end_date.to_i}")
			JSON.parse(response)
		end
	end