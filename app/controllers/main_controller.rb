class MainController < ApplicationController
  def index
    @top = Work.top
    @top_ten_movies = Work.top_ten_movies
    @top_ten_music = Work.top_ten_music
    @top_ten_books = Work.top_ten_books
  end

end
