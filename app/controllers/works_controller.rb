class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @works = Work.find_by(id: params[:id].to_i)
  end

  def edit
    @work = Work.find_by(id: params[:id].to_i)

    unless @work
      redirect_to works_path
    end
  end

  def update
    @work = Work.find_by(id: params[:id].to_i)
    redirect_to works_path unless @work

    if @work.update_attributes work_params
      redirect_to works_path
    else
      render :edit
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

  def destroy
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
