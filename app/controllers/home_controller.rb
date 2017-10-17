class HomeController < ApplicationController
  def index
    @albums = Work.top_ten_works("album")
    @books = Work.top_ten_works("book")
    @movies = Work.top_ten_works("movie")
    @top = Work.top_work
    unless @top
      @new = "none"
    end
  end
end
