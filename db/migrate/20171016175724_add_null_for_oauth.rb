class AddNullForOauth < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :uid, false
    change_column_null :users, :provider, false
  end
end
