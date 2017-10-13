class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  validates :user_id, presence: true, uniqueness: { scope: :work_id, message: "duplicate vote record; a vote record must be unique (a user cannot vote for the same work twice)" }
  validates :work_id, presence: true


  #how to add a validation that there cannot be a vote by the same user for the same worK?
  #I should also add this migration:
#   class AddUniqueIndexToVotes < ActiveRecord::Migration
#   def change
#     add_index :votes, [:work_id, :user_id], unique: true
#   end
# end
end
