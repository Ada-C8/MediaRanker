class WorksController < ApplicationController
  def main
    @works = Work.all
    @albums = Work.albums
    @books = Work.books
    @movies = Work.movies
  end

  def index
    @works = Work.all
    @albums = Work.albums
    @books = Work.books
    @movies = Work.movies
    # Will this still work?  Should I do @works = Work.all...  Incessent debate.
  end

  def show
    @work = Work.find_by(id: params[:id].to_i)
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new work_params
    if @work.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @work = Work.find_by(id: params[:id].to_i)

    unless @work
      redirect_to root_path
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

  def destroy
    Work.find_by(id: params[:id]).destroy
    redirect_to root_path
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
