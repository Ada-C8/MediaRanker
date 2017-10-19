class DropUnusedTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :albums
    drop_table :movies
    drop_table :books
  end
end
