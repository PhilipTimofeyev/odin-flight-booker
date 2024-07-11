class Booking < ApplicationRecord
	has_many :passengers
	validates_associated :passengers
	belongs_to :flight, optional: true

	accepts_nested_attributes_for :passengers

	def passengers_attributes=(passengers_attributes)
		passengers_attributes.each do |i, passenger_attributes|
			self.passengers.build(passenger_attributes)
		end
	end
end
