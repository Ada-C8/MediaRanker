class WorksController < ApplicationController
  def index
    @works = Work.order(:id)
  end

  def homepage
    @albums = Work.where("category = 'album'")
    @books = Work.where("category = 'book'")
    @movies = Work.where("category = 'movie'")
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work == nil
      redirect_to root_path
    end
  end

  def new
  end

  def create
  end

  def destroy
  end

  def edit
  end

  def update
  end

end
