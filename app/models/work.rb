class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true

  def self.sort_by_category(category)
    works_of_category = Work.where(category: category)

    return works_of_category
  end
end
