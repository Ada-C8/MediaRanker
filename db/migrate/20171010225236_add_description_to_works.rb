class AddDescriptionToWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :description, :string
  end
end
