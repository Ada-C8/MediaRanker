class MediaInstance < ApplicationRecord
  validates :title, :media_type, presence: true
  has_many :votes

  def self.ten_music
    where(media_type: "music").order(:votes.length).first(10)
  end

  def self.ten_movie
    where(media_type: "movie").order(:votes.length).first(10)
  end

  def self.ten_books
    where(media_type: "book").order(:votes.length).first(10)
  end
end
