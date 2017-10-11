class WorksController < ApplicationController
  def index
    @works = Work.all
    @movies = Work.where(category: "movie")
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
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

  def show
    @work = Work.find(params[:id])
    @votes = Vote.where(work_id: params[:id])
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    @work.update_attributes(work_params)
    if @work.save
      redirect_to work_path(@work)
    else
      render :edit
    end
  end

  def destroy
    @work = Work.find(params[:id])
    @work.destroy
    redirect_to works_path
  end
  def work_params
    # params are what fields the user is allowed to set
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  end
end
