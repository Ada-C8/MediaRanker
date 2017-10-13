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
    strong_params = work_params
    @work = Work.new(strong_params)
    @work.save

    if @work.save
      redirect_to works_path
    else
      render :new
    end
  end

  def update
    strong_params = work_params
    @work = Work.find(params[:id])
    @work.update_attributes(strong_params)
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
  return params.require(:work).permit(:title, :category)
end


end
