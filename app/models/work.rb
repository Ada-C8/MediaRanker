class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true

  def self.sort_by_category(category)
    return Work.where(category: category)
  end

  def self.popular(category: nil)
    if category
      works = Work.sort_by_category(category)
    else
      works = Work.all
    end

    return works.sort_by{ |work| -work.votes.count}
  end

  def self.most_popular
    return popular.first
  end

  def self.top_10(category)
    return popular(category: category)[0..9]
  end

  # def vote_by(user)
  #   return Work.where(user_id: user.id).votes
  # end
end
