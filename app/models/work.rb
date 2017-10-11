require 'date'

class Work < ApplicationRecord

  belongs_to :category
  validates_presence_of :title, :creator, :publication_year
  validates :publication_year, numericality: { only_integer: true }
  validates :title, uniqueness: { scope: [:category_id, :creator], message: "Duplicated works not allowed" }
  validate :publication_year_cannot_be_in_future, if: Proc.new { publication_year.is_a?Integer }

  private

  def publication_year_cannot_be_in_future
    max_date = Date.today.year

    if publication_year > max_date
      errors.add(:publication_year, "can't be later than this year")
    end
  end

end
