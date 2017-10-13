class WorksController < ApplicationController
  def index
    @works = Work.all
    @albums = Work.where(category: "album").all.limit(10)
    @books = Work.where(category: "book").all.limit(10)
    @movies = Work.where(category: "movie").all.limit(10)
  end

  def show
    @work = Work.find_by_id(params[:id])
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

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
