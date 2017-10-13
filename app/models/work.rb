class Work < ApplicationRecord
  has_many :vote

  validates :title, presence: true

  def self.top_ten(media_type)
    works = Work.all.where(category: media_type)
    vote_hash = {}

    top_ten = works.all.sort_by { |work| -work.vote.count}[0..9]


    # works.each do |work|
    #   work_votes = Vote.all.where(work_id: work.id).count
    #   vote_hash[work.id] = work_votes
    # end
    # top_ten = vote_hash.sort_by { |work_id, work_votes| work_votes}.reverse[0..9]
    return top_ten
  end

  def self.top_work
    Work.all.sort_by { |work| -work.vote.count}.first
  end

end
