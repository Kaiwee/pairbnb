class AddImageToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :image, :json
  end
end