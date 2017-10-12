class WorksController < ApplicationController
  def index
    # @work = Work.find_by(id: params[:id])
    # @book_work = @work.where(category: "book").order(:title)
    # @movie_work = @work.where(category: "movie").order(:title)
    # @album_work = @work.where(category: "album").order(:title)

    @book_work = Work.where(category: "book").order(:title)
    @movie_work = Work.where(category: "movie").order(:title)
    @album_work = Work.where(category: "album").order(:title)

  end

  def show
    @work = Work.find_by(id: params[:id])

    unless @work
      render_404
    end

    @vote = Vote.all

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

private
