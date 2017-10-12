class Work < ApplicationRecord
  has_many :votes

  def self.top_ten
    top_ten = all.sort_by do |work|
      work.votes.count
    end
    return top_ten[0...10]
  end
end
