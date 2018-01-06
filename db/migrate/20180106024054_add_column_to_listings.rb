class AddColumnToListings < ActiveRecord::Migration[5.1]
  def change
  	add_column :listings, :max_num_guests, :integer
  end
end
