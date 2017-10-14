class ChangePublicationToPublicationYear < ActiveRecord::Migration[5.1]
  def change
    remove_column :works, :publication, :integer
    add_column :works, :publication_year, :integer
  end
end
