class HomeController < ApplicationController
  def index
    @spotlight = Work.most_popular
    @books = Work.top_10("book")
    @albums = Work.top_10("album")
    @movies = Work.top_10("movie")
  end
end
