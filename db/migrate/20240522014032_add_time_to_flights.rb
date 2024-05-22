class AddTimeToFlights < ActiveRecord::Migration[7.1]
  def change
    add_column :flights, :time, :time
  end
end
