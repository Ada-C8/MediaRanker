class HomeController < ApplicationController
  def index
    # @media_spotlight = Work.first
    #
    # @top_movies = Work.where(category: "movie").limit(10)
    # @top_albums = Work.where(category: "album").limit(10)
    # @top_books = Work.where(category: "book").limit(10)

    @media_spotlight = Work.media_spotlight

    @top_movies = Work.top_ten_movies
    @top_albums = Work.top_ten_albums
    @top_books = Work.top_ten_books
  end
end
