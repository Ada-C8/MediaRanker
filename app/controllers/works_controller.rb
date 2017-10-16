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

  def home
    @top_work = (Work.all).first
    @albums =(Work.albums).first(10)
    @books = (Work.books).first(10)
    @movies = (Work.movies).first(10)
  end
  #need a better order method including votes

  def index
    @works = Work.all
    @albums = Work.albums
    @books = Work.books
    @movies = Work.movies
    @top_work = Work.order(:id).first
  end

  def show
    @work = Work.find( params[:id].to_i)
    unless @work
      render_404
    end
  end

  def new
    @work = Work.new
  end

  def update
    @work = Work.find_by(id: params[:id])

    unless @work
      flash[:error] = "Item with id #{params[:id]} not found"
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
    @work = Work.find_by(id: params[:id])
    if @work
      @work.destroy
      flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
      redirect_to root_path
    else
      render_404
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def show
    @work = Work.find( params[:id].to_i)
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def render_404
    render file: "/public/404.html", status: 404
  end

end
