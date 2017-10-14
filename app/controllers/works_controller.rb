class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

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
    @work = Work.new(work_params)
    if @work.save
      redirect_to works_path
    else
      render :new
    end
  end

  def edit
    unless @work
      redirect_to works_path
    end
  end

  def update
    redirect_to works_path unless @work
    if @work.update_attributes work_params
      redirect_to works_path
    else
      render :edit
    end
  end

  def destroy
    @work.destroy
    redirect_to root_path
  end

  def home
    @top_books
    @top_albums
    @top_movies
  end

  private

  def work_params
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
