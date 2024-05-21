class ChangeDurationToBeIntegerInFlights < ActiveRecord::Migration[7.1]
  def change
    change_column :flights, :flight_duration, :integer
  end
end
