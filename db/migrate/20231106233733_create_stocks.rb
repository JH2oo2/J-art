class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.integer :quantity
      t.integer :price
      t.string :name
      t.string :index

      t.timestamps
    end
  end
end
