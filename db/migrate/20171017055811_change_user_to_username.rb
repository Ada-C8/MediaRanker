class ChangeUserToUsername < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :user, :username
  end
end
