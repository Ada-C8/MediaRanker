class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  def index
    @works = Work.get_works
  end

  def show
    unless @work
      render_404
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
      render :new, status: 500
    end
  end

  def edit
    unless @work
      redirect_to root_path
    end
  end

  def update
   redirect_to work_path unless @work
   if @work.update_attributes work_params
     redirect_to work_path
   else
     render :edit, status: 500
   end
  end

  def destroy
    @work.destroy if work
    redirect_to root_path
  end

  private
  def find_work
    @work = Work.find_by(id: params[:id].to_i)
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
