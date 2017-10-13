class FixColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :string
    remove_column :works, :string
    remove_column :works, :integer
    remove_column :votes, :integer
  end
end
