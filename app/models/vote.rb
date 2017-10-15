class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  validates :user_id, presence: true, uniqueness: { scope: :work_id, message: "duplicate vote record; a vote record must be unique (a user cannot vote for the same work twice)" }
  validates :work_id, presence: true



# In addition to the validation, should I also add this migration?:
#   class AddUniqueIndexToVotes < ActiveRecord::Migration
#   def change
#     add_index :votes, [:work_id, :user_id], unique: true
#   end
# end


#creates a hash with key is title and value is 0
# def empty_works_hash
#   media_votes = Hash.new
#   Work.all.each do |work|
#     media_votes[work] = 0
#   end
#   return media_votes
# end

#counts votes for all media
def media_votes
  media_votes = Hash.new
  Work.all.each do |work|
    media_votes[work] = 0
  end

  Vote.all.each do |vote|
    media_votes.each do |media, media_vote|
      if vote.work_id == media.id
          media_votes[media] += 1
      end
    end
  end
  return media_votes
end

def specific_media_votes(category)
  new_hash = Hash.new
  media_votes.each do |media, media_vote|
    if vote.category = category
      new_hash[media] = media_vote
    end
  end
end


def spotlight_media(media_votes)
  winner = media_votes.self.sort_by{|key, value| -value }[0]
  return winner
end


end
