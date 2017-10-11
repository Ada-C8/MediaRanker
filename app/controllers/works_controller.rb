class WorksController < ApplicationController
  def index
    books = Work.where(category: "book")
    movies = Work.where(category: "movie")
    albums = Work.where(category: "album")
    @works = {Albums: albums, Books: books, Movies: movies}
  end

  def new
  end

  def show
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end
end
