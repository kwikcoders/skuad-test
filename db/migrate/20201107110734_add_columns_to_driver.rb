class AddColumnsToDriver < ActiveRecord::Migration[6.0]
  def change
    add_column :drivers, :latitude, "double"
    add_column :drivers, :longitude, "double"
  end
end
