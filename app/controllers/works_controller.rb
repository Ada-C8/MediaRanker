class WorksController < ApplicationController
  def index
    @albums = Work.albums
    @books = Work.books
    @movies = Work.movies
    # Will this still work?  Should I do @works = Work.all...  Incessent debate.
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
