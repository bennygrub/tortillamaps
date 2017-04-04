class AddHoursToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :hours, :text
  end
end
