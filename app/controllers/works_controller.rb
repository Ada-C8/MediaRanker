class WorksController < ApplicationController
  def home
    @homepage = true
    @works = Work.all

    @spotlight = Work.spotlight
    @books = Work.top_ten("book")
    @movies = Work.top_ten("movie")
    @albums = Work.top_ten("album")
  end

  def index
    @books = Work.popularity("book")
    @movies = Work.popularity("movie")
    @albums = Work.popularity("album")
  end

  def show
    @work = Work.find_by(id: params[:id].to_i)

    head :not_found unless @work
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new work_params
    if @work.save
      flash[:success] = "Item successfully added"
      redirect_to root_path
    else
      flash.now[:success] = "Item could not be added"
      render :new
    end
  end

  def edit
    @work = Work.find_by(id: params[:id].to_i)

    head :not_found unless @work
  end

  def update
    @work = Work.find_by(id: params[:id].to_i)
    head :not_found unless @work

    if @work.update_attributes work_params
      flash[:success] = "Item successfully updated"
      redirect_to works_path
    else
      flash.now[:success] = "Item failed to update"
      render :edit
    end
  end

  def destroy
    Work.find_by(id: params[:id]).destroy
    flash[:success] = "Item deleted"
    redirect_to root_path
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
