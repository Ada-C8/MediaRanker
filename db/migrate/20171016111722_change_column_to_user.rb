class ChangeColumnToUser < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :name, true
    change_column_null :users, :joined_on, true

    change_column_null :votes, :category, true
    change_column_null :votes, :work_id, true
    change_column_null :votes, :user_id, true
    change_column_null :votes, :date, true

    change_column_null :works, :title, true
    change_column_null :works, :creator, true
    change_column_null :works, :published, true
    change_column_null :works, :category, true


  end
end
