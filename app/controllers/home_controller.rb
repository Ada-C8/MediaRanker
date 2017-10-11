class HomeController < ApplicationController
  def index
    @books = Work.where(category: "book").limit(10)
    @albums = Work.where(category: "album").limit(10)
    # @movies = 
  end
end
