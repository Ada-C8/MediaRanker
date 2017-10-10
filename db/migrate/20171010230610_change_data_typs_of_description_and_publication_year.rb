class ChangeDataTypsOfDescriptionAndPublicationYear < ActiveRecord::Migration[5.1]
  def change
    change_column :works, :description, :string
  end
end
