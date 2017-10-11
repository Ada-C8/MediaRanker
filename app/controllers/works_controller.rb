class WorksController < ApplicationController
  def index
    @book_works = Work.where(category: "book").order(:title)
    @movie_works = Work.where(category: "movie").order(:title)
    @album_works = Work.where(category: "album").order(:title)
  end

  def show
  end

  def edit
  end

  def update
  end

  def new
  end

  def create
  end

  def destroy
  end
end
