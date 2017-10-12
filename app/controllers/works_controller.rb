class WorksController < ApplicationController
  def index
    @works = Work.all
  end # index

  def show
  find_work_by_params
  end # show

  def new
    @work = Work.new
  end # new

  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to works_path
    else
      render :new, status: :bad_request
    end # if/else
  end # create

  private
  def find_work_by_params
    @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
    end
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end # work_params

end
