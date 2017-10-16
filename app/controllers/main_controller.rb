class MainController < ApplicationController
  def index
    @media_spotlight = Work.work_with_the_most_votes
    @top_movies = Work.top_n_in_category("movie", 10)
    @top_books = Work.top_n_in_category("book", 10)
    @top_albums = Work.top_n_in_category("album", 10)
  end
end
