class FixDatatypes < ActiveRecord::Migration[5.1]
  def change
    remove_column :votes, :user_id
    add_column :votes, :user_id, :integer
    remove_column :votes, :work_id
    add_column :votes, :work_id, :integer
    remove_column :works, :pub_year
    add_column :works, :pub_year, :integer
    remove_column :works, :description
    add_column :works, :description, :text
  end
end
