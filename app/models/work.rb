class Work < ApplicationRecord
  has_many :votes #, dependent: :destroy

  validates :title, presence: true, uniqueness: { message: "The title has already been taken" }

  def self.work_with_the_most_votes
    return Work.left_outer_joins(:votes).select('works.*, COUNT(votes.*) AS votes_count').group('works.id').order('votes_count desc').first
  end

  def self.top_ten(category)
    return Work.left_outer_joins(:votes).select('works.*, COUNT(votes.*) AS votes_count').group('works.id').where(category: category).order('votes_count desc').limit(10)
  end

  def self.all_with_vote_count()
    return Work.left_outer_joins(:votes).select('works.*, COUNT(votes.*) AS votes_count').group('works.id').order('votes_count')
  end

end
