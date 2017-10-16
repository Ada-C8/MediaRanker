class ChangeNamesOfCreatedByAndPublishedColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :works, :created_by, :creator
    rename_column :works, :published, :publication_year
  end
end
