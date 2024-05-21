class Flight < ApplicationRecord
	belongs_to :departure_airport, class_name: "Airport", optional: true
	belongs_to :arrival_airport, class_name: "Airport", optional: true
end
