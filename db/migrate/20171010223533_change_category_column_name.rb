class ChangeCategoryColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :categories, :cat, :name
  end
end
