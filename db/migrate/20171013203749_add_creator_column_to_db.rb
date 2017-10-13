class AddCreatorColumnToDb < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :creator, :string
  end
end
