class AddIcaoIdToAirports < ActiveRecord::Migration[7.1]
  def change
    add_column :flights, :icao_id, :string
  end
end
