require 'date'

class Work < ApplicationRecord
  belongs_to :category
  validates_presence_of :title, :creator, :publication_year
  #validates :title, uniqueness: { scope: [:category_id, :creator], message: "Duplicated works not allowed" }
  #validates :max_date

  #private

  def max_date
    max_date = Date.today.year

    if publication_year > max_date
      errors.add(:publication_year, "cannot be later than this year")
    end
  end

end
