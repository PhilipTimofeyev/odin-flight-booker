class Airport < ApplicationRecord
	has_many :departing_flights, foreign_key: "departure_airport_id", primary_key: :code, class_name: "Flight"
	has_many :arriving_flights, foreign_key: "arrival_airport_id", primary_key: :code, class_name: "Flight"
end