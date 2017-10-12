class WorksController < ApplicationController
  def home
  end

  def index
    @works = Work.all
  end

  # def edit
  #   @work = Work.find_by(id: params[:id])
  #   if @work == nil
  #     redirect_to works_path
  #   end
  # end

  def update
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
      redirect_to works_path
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
