require 'date'

class Work < ApplicationRecord

  belongs_to :category
  has_many :votes, dependent: :destroy
  validates_presence_of :title, :creator
  validates :publication_year, numericality: { only_integer: true }, allow_nil: true
  validates :title, uniqueness: { scope: [:category_id, :creator], message: "Duplicated works not allowed" }
  validate :publication_year_cannot_be_in_future, if: Proc.new { publication_year.is_a?Integer }

  def self.works_by_type(category_name)
    works_in_cat = Work.left_outer_joins(:votes).where(category_id: Category.find_by(name: category_name)).distinct.select('works.*, COUNT(votes.*) AS num_votes').group('works.id').order('num_votes DESC')

    return works_in_cat

  end

  def self.works_by_type_hash
    media_hash = {}
    cat_names = Category.all.map { |cat| cat.name }

    cat_names.each do |name|
      media_hash[name.pluralize] = works_by_type(name)
    end

    return media_hash
  end

  def self.top_ten(media_hash)
    media_hash.each do |cat_type, work_list|
      media_hash[cat_type] = work_list.limit(10)
    end

    return media_hash
  end

  def self.spotlight
    works = Work.left_outer_joins(:votes).distinct.select('works.*, COUNT(votes.*) AS num_votes').group('works.id').order('num_votes DESC')
    return works[0]
  end

  private

  def publication_year_cannot_be_in_future
    max_date = Date.today.year

    if publication_year > max_date
      errors.add(:publication_year, "can't be later than this year")
    end
  end

end
