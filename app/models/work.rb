class Work < ApplicationRecord
  belongs_to :user, optional: true
  has_many :votes
  validates :publication_year, numericality: { only_integer: true, allow_blank: true }
  validates :title, presence: true
  validates :creator, presence: true
  validates :category, presence: true


  def self.order_by_votes(type)
    return Work.where(category:type).sort_by { |work| work.votes.count }.reverse
  end

  def self.already_voted?(a_work, a_user)
    users = []
    Work.find(a_work).votes.each do |vote|
      users << vote.user_id
    end

    return users.include?(a_user)
  end
end
