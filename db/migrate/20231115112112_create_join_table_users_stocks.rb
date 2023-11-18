class CreateJoinTableUsersStocks < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :stocks, column_options: { null: false, foreign_key: true } do |t|
      t.index [:user_id, :stock_id]
      t.index [:stock_id, :user_id]
      # t.references :user, foreign_key: true
      # t.references :stock, foreign_key: true
    end
  end
end
