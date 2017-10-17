class ChangePubYearDataType < ActiveRecord::Migration[5.1]
  def change
    remove_column :works, :publication_year
    add_column :works, :publication, :integer
  end
end
