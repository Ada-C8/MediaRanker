class AddCategoryColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :category, :string
  end
end
