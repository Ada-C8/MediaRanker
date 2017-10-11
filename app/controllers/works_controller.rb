class WorksController < ApplicationController

  def index
    @albums = Work.albums
    @books = Work.books
    @movies = Work.movies
  end

  def new
    @work = Work.new
  end

end
