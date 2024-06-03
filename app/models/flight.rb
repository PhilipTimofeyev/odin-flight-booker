class Flight < ApplicationRecord
	belongs_to :departure_airport, primary_key: :code, class_name: "Airport", optional: true
	belongs_to :arrival_airport, primary_key: :code, class_name: "Airport", optional: true
	has_many :bookings
	has_many :passengers, through: :bookings
end
