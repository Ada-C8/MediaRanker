class ChangeDateToInt < ActiveRecord::Migration[5.1]
  def change
    change_column :works, :publication_year, :string, limit: 4
  end
end
