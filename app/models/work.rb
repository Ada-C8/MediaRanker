class Work < ApplicationRecord
  has_many :votes

  def self.all_works_by_title
    all_works = Work.order(:title).group_by { |work| work.category }
    return all_works
  end


  def self.spotlight
    top_voted = []
    all_works = all_works_by_title
    all_works = all_works.each do |key, values|
      all_works[key] = (values.sort_by {|value| value.votes.length}).reverse
      top_voted << all_works[key].first
    end
    spotlight = top_voted.inject do |memo, work|
      raise ArgumentError.new "Can only select spotlight from works" if !(work.is_a? Work)
      memo.votes.length >= work.votes.length ? memo : work
    end
    return spotlight
  end


end
