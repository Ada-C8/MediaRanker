class WorksController < ApplicationController
  def index
    @books = Work.where(category:"book")
    @movies = Work.where(category:"movie")
    @albums = Work.where(category:"album")
  end

  def new
  end

  def edit
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end
end
