class WorksController < ApplicationController
  def home
  end

  def index
    @works = Work.order(:id)
  end

  def edit
    @work = Work.find_by(id: params[:id])
    unless @work
      redirect_to work_path(@work.id)
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    redirect_to work_path(@work.id) unless @work

    if @work.update_attributes work_params
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work == nil
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work.id)
    else
      render :new
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id]).destroy
    redirect_to root_path
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
