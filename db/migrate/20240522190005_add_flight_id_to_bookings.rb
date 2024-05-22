class AddFlightIdToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :flight_id, :integer
  end
end
