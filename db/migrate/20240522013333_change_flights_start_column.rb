class ChangeFlightsStartColumn < ActiveRecord::Migration[7.1]
  def change
    change_column(:flights, :start, :date)
  end
end
