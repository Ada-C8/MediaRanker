class HomeController < ApplicationController
  def index

    # @albums = Work.top_works("album")
    # @books = Work.top_works("book")
    # @movies = Work.top_works("movie")
    @albums = Work.popular_works("album")
    @books = Work.popular_works("book")
    @movies = Work.popular_works("movie")
    # @albums = Work.all.where(category: "album").sort_by{|work| -work.votes.count}[0..9]
    # @books = Work.all.where(category: "book").sort_by{|work| -work.votes.count}[0..9]
    # @movies = Work.all.where(category: "movie").sort_by{|work| -work.votes.count}[0..9]

    #how can you methodize this and put into the model?
  end
end
