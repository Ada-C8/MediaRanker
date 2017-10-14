class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true, uniqueness: true
  validates :category, presence: true, inclusion: { in: %w(movie book album), message: "%{value} is not a valid input for category. Accepts categories movie, book, or album" }

  #The following test fails when I include the first pub_year validation below:
  #test_0003_requires both a title and category to be created
  # validates :pub_year, presence: false, format: { with: /\d{4}/,
  #   message: "only allows a year format of 4 numbers (ex. 2017)" }
  # validates :pub_year, numericality: { only_integer: true, less_than: 2018 }


  def total_votes(id)
    counter = 0
    votes.each do |vote|
      if vote.work_id == id
        counter += 1
      end
    end
    return counter
  end

  #creates a hash with key is title and value is 0
  # def empty_works_hash
  #   media_votes = Hash.new
  #   Work.all.each do |work|
  #     media_votes[work] = 0
  #   end
  #   return media_votes
  # end

  #counts votes for all media
  def media_votes
    media_votes = Hash.new
    Work.all.each do |work|
      media_votes[work] = 0
    end

    Vote.all.each do |vote|
      media_votes.each do |media, media_vote|
        if vote.work_id == media.id
            media_votes[media] += 1
        end
      end
    end
    return media_votes
  end

  def specific_media_votes(category)
    new_hash = Hash.new
    media_votes.each do |media, media_vote|
      if vote.category = category
        new_hash[media] = media_vote
      end
    end
  end


  def spotlight_media(media_votes)
    winner = media_votes.self.sort_by{|key, value| -value }[0]
    return winner
  end



end
