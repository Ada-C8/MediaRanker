class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true
  validates :title, uniqueness: true

  def self.all_works_by_title
    all_works = Work.order(:title).group_by { |work| work.category }
    return all_works
  end


  def self.spotlight(input_works)
    top_voted = []
    all_works = input_works
    return nil if input_works.keys == 0
    all_works = all_works.each do |key, values|
      values.each do |value|
        raise ArgumentError.new "Can only select spotlight from works" if !(value.is_a? Work)
      end
      all_works[key] = (values.sort_by {|value| value.votes.length}).reverse
      top_voted << all_works[key].first
    end
    spotlight = top_voted.inject do |memo, work|
      memo.votes.length >= work.votes.length ? memo : work
    end
    return spotlight
  end


end
