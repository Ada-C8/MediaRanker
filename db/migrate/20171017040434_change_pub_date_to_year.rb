class ChangePubDateToYear < ActiveRecord::Migration[5.1]
  def change
    rename_column :works, :publication_date, :publication_year
  end
end
