class MediaInstance < ApplicationRecord
  validates :title, :media_type, presence: true
  has_many :votes

  def self.ten_by_type(type)
    where(media_type: type).sort{|instance| instance.votes.count}.reverse
  end

  # def self.ten_music
  #   where(media_type: "music").sort{|book| book.votes.count}.reverse
  # end
  #
  # def self.ten_movie
  #   where(media_type: "movie").sort{|book| book.votes.count}.reverse
  # end
  #
  # def self.ten_books
  #   binding.pry
  #   where(media_type: "book").sort{|book| book.votes.count}.reverse
  # end
end
