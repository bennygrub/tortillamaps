class AddImagesToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :images, :json
  end
end
