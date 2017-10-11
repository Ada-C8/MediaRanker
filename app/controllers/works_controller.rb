class WorksController < ApplicationController
  def index
    @works = Work.get_works
    print @works
  end

  def show
    @work = Work.find_by(id: params[:id].to_i)
    unless @work
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new work_params
    if @work.save
      redirect_to works_path
    else
      render :new
    end
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
