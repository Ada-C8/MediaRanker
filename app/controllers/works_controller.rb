class WorksController < ApplicationController
  def home
    @albums = Work.top10albums
    @books = Work.top10books
    @movies = Work.top10movies
  end

  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id].to_i)
    unless @work
      render_404
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(works_params)
  if @work.save
    redirect_to root_path
  else
    render :new
  end
  end

  def edit
    @work = Work.find_by(id: params[:id].to_i)
  end

  def update
    @work = Work.find_by(id: params[:id].to_i)
    if @work.update_attributes works_params
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    Work.find_by(id: params[:id]).destroy
    redirect_to root_path
  end

  private

  def works_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
