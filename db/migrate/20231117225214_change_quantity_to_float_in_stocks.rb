class ChangeQuantityToFloatInStocks < ActiveRecord::Migration[7.0]
  def change
    change_column :stocks, :quantity, :float
  end
end
