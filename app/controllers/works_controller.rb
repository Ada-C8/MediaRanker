class WorksController < ApplicationController
  def index
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")
    @books = Work.where(category: "book")
  end

  def show
    @work = Work.find(params[:id])
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    result = @work.update(work_params)

    if result
      redirect_to work_path(params[:id])
    else
      #error message
    end
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
