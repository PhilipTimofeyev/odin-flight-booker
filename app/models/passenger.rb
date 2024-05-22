class Passenger < ApplicationRecord
	belongs_to :booking, optional: true
end
