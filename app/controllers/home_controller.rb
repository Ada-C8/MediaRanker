class HomeController < ApplicationController

  def index
    @books = Work.where(category: "book").limit(10)
    @movies = Work.where(category: "movie").limit(10)
    @albums = Work.where(category: "album").limit(10)
    @spotlight = Vote.media_spotlight
  end



end
