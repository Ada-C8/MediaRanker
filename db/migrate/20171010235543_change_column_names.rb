class ChangeColumnNames < ActiveRecord::Migration[5.1]
  def change
    rename_column(:works, :author, :creator)
    rename_column(:works, :publication_date, :publication_year)
  end
end
