class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show
    @work = Work.find(params[:id])
  end

  def new
    @work = Work.new
  end

  def edit
    @work = Work.find(params[:id])
  end

  def create
    @work = Work.new(work_params)
    @work.save
    if @work.save
      redirect_to works_path
    else
      render :new
    end
  end

  def update
    @work =Work.find(params[:id])
    @work.update_attributes(driver_params)
    @work.save

    redirect_to works_path
  end

  def destroy
    work = Work.find(params[:id])
    work.destroy
    redirect_to works_path
  end

  private
  def work_params
    return params.require(:work).permit(:title)
  end


end
