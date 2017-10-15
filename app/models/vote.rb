class Vote < ApplicationRecord
  belongs_to :work, counter_cache: true
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :work_id, message: "You have already voted."}

  # def self.top_10(category)
  #   Work.where(category: category).sort_by {|work| work.total_votes }.reverse.limit(10)
  # end

  def total_votes
    return 0 if votes.empty?
    votes.map {|vote| vote.value }.inject(:+)
  end

end
