class ChangeDepartureAirportIdToBeStringInFlights < ActiveRecord::Migration[7.1]
  def change
    change_column :flights, :departure_airport_id, :string
    change_column :flights, :arrival_airport_id, :string
  end
end
