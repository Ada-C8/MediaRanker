class WorksController < ApplicationController
  def index
    @works = Work.all#.order('title asc')
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to('/works')
    else
      render :new
    end

  end

  def new
    @work = Work.new
  end

  def edit
    @work = Work.find(params[:id])
  end

  def show
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    @work.update_attributes(work_params)
    if @work.save
      redirect_to(work_path(@work))
    else
      render :new
    end
  end

  def destroy
    @work = Work.find(params[:id])
    @work.destroy

    redirect_to works_path
  end

private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
