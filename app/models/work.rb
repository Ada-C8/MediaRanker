class Work < ApplicationRecord
  has_many :vote

  validates :title, presence: true
  validates :category, presence: true

  def self.top_ten(media_type)
    works = Work.all.where(category: media_type)
    if works
      vote_hash = {}

      top_ten = works.all.sort_by { |work| -work.vote.count}[0..9]
      return top_ten
    end
  end

  def self.top_work
    if Work.all
      Work.all.sort_by { |work| -work.vote.count}.first
    end
  end

end
