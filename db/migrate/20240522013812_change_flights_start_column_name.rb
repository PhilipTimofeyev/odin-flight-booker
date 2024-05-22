class ChangeFlightsStartColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :flights, :start, :date
  end
end
