class MainController < ApplicationController
  def index
    @media_spotlight = Work.first
    @top_movies = Work.top_movies
    @top_books = Work.where(category: "book").limit(10)
    @top_albums = Work.where(category: "album").limit(10)
  end
end
