class AddTitleToWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :title, :string
  end
end
