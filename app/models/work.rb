class Work < ApplicationRecord
  has_many :vote

  validates :title, presence: {message: "Work needs a title"}
  validates :category, presence: {message: "Work needs a category"}

  def self.sorted
    works = Work.all
    @sorted = works.sort_by{|work| -work.vote.count}
  end

  def self.top
    top = self.sorted.first
    return top
  end

  def self.top_ten_movies
    top_ten = []
    if @sorted
      @sorted.each do |work|
        if work.category == "Movie"
          top_ten << work
        end
        break if top_ten.length > 10
      end
    end
    return top_ten
  end

  def self.top_ten_music
    top_ten = []
    if @sorted
      @sorted.each do |work|
        if work.category == "Music"
          top_ten << work
        end
        break if top_ten.length > 10
      end
    end
    return top_ten
  end

  def self.top_ten_books
    top_ten = []
    if @sorted
      @sorted.each do |work|
        if work.category == "Book"
          top_ten << work
        end
        break if top_ten.length > 10
      end
    end
    return top_ten
  end

end
