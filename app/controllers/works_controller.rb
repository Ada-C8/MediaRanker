class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def show
    @work = Work.find(params[:id])
  end



  private
  def driver_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
