class WorksController < ApplicationController
  def index
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")
  end

  def show
  end

  def new
    @work = Work.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  def home
  end
end
