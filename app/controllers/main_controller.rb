class MainController < ApplicationController
  def index
    @media_spotlight = Work.work_with_the_most_votes
    @top_movies = Work.top_ten("movie")
    @top_books = Work.top_ten("book")
    @top_albums = Work.top_ten("album")
  end
end
