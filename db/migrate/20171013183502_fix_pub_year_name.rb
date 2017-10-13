class FixPubYearName < ActiveRecord::Migration[5.1]
  def change
    rename_column :works, :publication, :publication_year
  end
end
