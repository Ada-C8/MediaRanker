class AddUserToWorks < ActiveRecord::Migration[5.1]
  def change
    add_reference :works, :user, foreign_key: true#, index: true
  end
end
