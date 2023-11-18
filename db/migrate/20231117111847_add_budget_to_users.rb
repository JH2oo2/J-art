class AddBudgetToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :budget, :float, default: 1000.0
  end
end
