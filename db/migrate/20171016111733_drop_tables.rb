class DropTables < ActiveRecord::Migration[5.1]
  def down
    drop_table :albums
    drop_table :books
    drop_table :movies

  end
end
