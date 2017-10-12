class WorksController < ApplicationController
  def index
    @works = Work.all.order(:category, :title)
  end

  def show
    @work = Work.find(params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    @work.save
    redirect_to works_index_path
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    @work.update_attributes(work_params)
    @work.save
    redirect_to works_index_path
  end

  def destroy
    @work = Work.find(params[:id])
    @work.destroy
    redirect_to works_index_path
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
