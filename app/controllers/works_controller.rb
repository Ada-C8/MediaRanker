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
      redirect_to @work
    else
      render :new
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])
    if work
      work.destroy
      flash[:success] = "Work ##{work.id} was successfully deleted."
    else
      flash[:fail] = "Work cannot be deleted."
    end
    redirect_to root_path
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
