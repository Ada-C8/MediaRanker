class ChangeNameOfPubYear < ActiveRecord::Migration[5.1]
  def change
    rename_column :works, :publicaton_year, :publication_year
  end
end
