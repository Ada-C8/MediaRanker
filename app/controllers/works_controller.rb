class WorksController < ApplicationController
  def index
    @works = Work.order(:id)
  end


  def show
    @work = Work.find_by(id: params[:id].to_i)
    # @votes = Vote.where(work_id: params[:id].to_i).order(sort_string)

    # if work not found
    unless @work
      flash[:error] = "Media not found"
      redirect_to works_path
    end
  end


  def create
    @work = Work.new work_params

    if @work.save
      redirect_to root_path
    else
      render :new
    end
  end


  def update
    @work = Work.find_by(id: params[:id].to_i)
    # redirect_to works_path unless @work

    if @work.update_attributes work_params
      redirect_to root_path
    else
      render :edit
    end

  end


  def destroy
    @work = Work.find_by(id: params[:id].to_i)
    @work.destroy
    redirect_to root_path
  end


  def edit
    @work = Work.find_by(id: params[:id].to_i)

    unless @work
      redirect_to works_path
    end
  end


  def new
    @work = Work.new
  end


  private

  def work_params
    # return params.require(:work).permit(:title, :author, :description, :price)
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end


end
