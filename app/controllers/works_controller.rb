class WorksController < ApplicationController
  def create
    @work = Work.create work_params
    if @work.id != nil
      flash[:success] = "Item added successfully!"
      redirect_to works_path
    else
      flash[:error] = "Error - create unsuccessful"
      render :new
    end
  end

  def new
    @work = Work.new
  end


  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end


  def destroy
    Work.find_by(id: params[:id]).destroy
    redirect_to root_path
  end

  def edit
  end

  def index
    @works = Work.all
    @albums = Work.albums
    @books = Work.books
    @movies = Work.movies
  end


  def show
    @work = Work.find( params[:id].to_i)
  end

  def update
  end
end
