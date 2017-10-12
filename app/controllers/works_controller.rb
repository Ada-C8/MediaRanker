class WorksController < ApplicationController

  def home
    @top_work = Work.order(:id).first
    @albums = Work.albums.first(10)
    @books = Work.books.first(10)
    @movies = Work.movies.first(10)
  end

  def index
    @albums = Work.albums
    @books = Work.books
    @movies = Work.movies
  end

  def show
    @work = Work.find( params[:id].to_i )

    unless @work
      render_404
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new

    @work = Work.create work_params
    if @work.id != nil
      flash[:success] = "Book added successfully!"
      redirect_to works_path
    else
      flash[:error] = "A problem occurred. Coult not create work"
      render :new
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
    @work = Work.find_by(id: params[:id])

    unless @work
      flash[:error] = "Driver with id #{params[:id]} not found"
      redirect_to works_path
    end

    if @work.update_attributes work_params
      flash[:success] = "Book added successfully!"
      redirect_to works_path
    else
      flash[:error] = "Book unable to update"
      render :edit
    end
  end

  def destroy
    Work.find_by(id: params[:id]).destroy

    redirect_to works_path
  end

private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
