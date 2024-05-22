class AddNumOfPassengersToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :num_of_passengers, :integer
  end
end
