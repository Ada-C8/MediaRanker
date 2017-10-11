class MainController < ApplicationController
  def index
    @movies = Work.where(category: "movie").limit(10)
    @books = Work.where(category: "book").limit(10)
    @albums = Work.where(category: "album").limit(10)
  end
end
