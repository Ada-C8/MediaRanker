class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :category,
            presence: true
  validates :title,
            presence: true,
            uniqueness: {
                          scope: :category,
                          message: "This work already exists"
                        }
  validates :publication_year,
            allow_blank: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1000
            }

  after_initialize :set_default
  def set_default
    if self.creator.blank?
      self.creator = "Anonymous"
    end
  end
end
