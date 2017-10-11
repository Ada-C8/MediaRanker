class WorksController < ApplicationController
  def index
    @books = Work.where(category:"book")
    @movies = Work.where(category:"movie")
    @albums = Work.where(category:"album")
  end

  def new
    @work = Work.new
  end

  def edit
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to works_path
    else
      render :new
    end
  end

  def show
    @work = Work.find_by(id: params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def work_params
    params.require(:work).permit(:title, :category, :description, :creator, :publication_year)
  end
end
