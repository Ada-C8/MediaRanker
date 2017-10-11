class WorksController < ApplicationController
  def index
    @works = Work.order(:id)
  end

  def homepage
    @albums = Work.where("category = 'album'")
    @books = Work.where("category = 'book'")
    @movies = Work.where("category = 'movie'")
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work == nil
      redirect_to root_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_parameters)
    if @work.save
      redirect book_path(@work.id)
    else
      render :new
    end
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private
  def work_parameters
    params.require(:work).permit(:title, :category, :creator, :description, :publication_year)
  end

end
