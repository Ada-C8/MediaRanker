class WorksController < ApplicationController

  def home
    @homepage = true
  end

  def create
  end

  def destroy
  end

  def edit
    @work = Work.find_by(id: params[:id])
    unless @work
      redirect_to works_path
    end
  end

  def new
  end

  def show
    @work = Work.find_by(id: params[:id])
  end

  def update
  end

  def index
    @works = Work.order(:category)
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title)
  end

end
