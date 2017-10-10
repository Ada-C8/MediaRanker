class AddNewColumnDescruption < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :description, :text
  end
end
