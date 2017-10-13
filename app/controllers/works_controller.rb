class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :delete]

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
  end

  def update
  end

  def delete
  end

  def home
  end

  private

  def work_params
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
