class Work < ApplicationRecord
  has_many :votes

  def votes_count
    return "n0 v0tes" if work.votes == nil
    return work.votes.length
  end
end
