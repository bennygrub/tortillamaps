class AddPlaceIdToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :place_id, :string
    add_column :restaurants, :rating, :float
    add_column :restaurants, :price, :integer
  end
end
