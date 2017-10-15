class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def home
    @albums = Work.top10albums
    @books = Work.top10books
    @movies = Work.top10movies
    @topwork = Work.topwork[0]
  end

  def index
    @works = Work.all
  end

  def show
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
    flash[:success] = "Successfully added #{@work.title}!"
    redirect_to root_path
  else
    render :new
  end
  end

  def edit
  end

  def update
    if @work.update_attributes works_params
      flash[:success] = "Successfully edited #{@work.title}!"
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @work.destroy
    flash[:success] = "Successfully deleted media."
    redirect_to root_path
  end

  private

  def works_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id].to_i)
  end

end
