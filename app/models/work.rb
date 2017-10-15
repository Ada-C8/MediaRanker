class Work < ApplicationRecord
  has_many :vote

  validates :title, presence: true
  validates :category, presence: true

  # def self.top_ten(media_type)
  #   if Work.all.count != 0
  #     works = Work.all.where(category: media_type)
  #     vote_hash = {}
  #
  #     top_ten = works.all.sort_by { |work| -work.vote.count}[0..9]
  #     return top_ten
  #   end
  # end

  def sort
    if Work.all.count != nil
      Work.all.sort_by { |work| -work.vote.count}.first
    end
  end

  def self.top_ten_albums
    works =  Work.all.count
    top_albums = []
    if works == 0
      return top_albums
    end
    works.each do |work|
      if work.category == "album"
        top_albums << work
      end
      return top_albums
    end
  end

  def self.top_ten_books
    works =  Work.all.count
    top_books = []
    if works == 0
      return top_books
    end
    works.each do |work|
      if work.category == "book"
        top_books << work
      end
      return top_books
    end
  end

  def self.top_ten_movies
    works =  Work.all.count
    top_movie = []
    if works == 0
      return top_movie
    end
    works.each do |work|
      if work.category == "movie"
        top_movie << work
      end
      return top_movie
    end
  end


  def self.top_work
    if Work.all.count != nil
      Work.all.sort_by { |work| -work.vote.count}.first
    end
  end
