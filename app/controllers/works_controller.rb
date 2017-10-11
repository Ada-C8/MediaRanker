class WorksController < ApplicationController
  def index
    @books = Work.where(category:"book")
    @movies = Work.where(category:"movie")
    @albums = Work.where(category:"album")
  end

  def new
    @work = Work.new
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to works_path
    else
      render :new
    end
  end

  def show
    @work = Work.find_by(id: params[:id])
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.update(work_params)
      redirect_to works_path
    else
      render :edit
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    @work.destroy
    redirect_to works_path
  end

  private

  def work_params
    params.require(:work).permit(:title, :category, :description, :creator, :publication_year)
  end
end
