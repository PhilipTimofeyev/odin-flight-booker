class Passenger < ApplicationRecord
	belongs_to :booking
	validates_presence_of :name, :email
end
