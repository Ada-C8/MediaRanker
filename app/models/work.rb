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

  def self.sort
    if Work.all.count != 0
      Work.all.sort_by { |work| -work.vote.count}
    end
  end

  def self.top_ten_albums
    works =  Work.sort
    top_albums = []
    if works == []
    else
      works.each do |work|
        if work.category == "album"
          top_albums << work
        end
      end
    end
    return top_albums[0..9]
  end

  def self.top_ten_books
    works =  Work.sort
    top_books = []
    if works == []
      return top_books
    end

    works.each do |work|
      if work.category == "book"
        top_books << work
      end
    end
    return top_books[0..9]
  end

  def self.top_ten_movies
    works =  Work.sort
    top_movie = []
    if works == []
      return top_movie
    end
    works.each do |work|
      if work.category == "movie"
        top_movie << work
      end
    end
    return top_movie[0..9]
  end


  def self.top_work
    if Work.all.count != 0
      Work.all.sort_by { |work| -work.vote.count}.first
    end
  end
end
