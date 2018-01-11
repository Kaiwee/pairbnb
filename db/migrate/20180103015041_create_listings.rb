class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :title
      t.string :address
      t.integer :price

      t.timestamps null: false
    end
  end
end