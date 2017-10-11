class WorksController < ApplicationController
  def index
    @books = Work.where(category:"book")
    @movies = Work.where(category:"movie")
    @albums = Work.where(category:"album")
  end

  def new
    @work = Work.new
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:sucess] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      render :new
    end
  end

  def show
    @work = Work.find_by(id: params[:id])
    unless @work
      render_404
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    @work.destroy
    redirect_to works_path
  end

  private

  def work_params
    params.require(:work).permit(:title, :category, :description, :creator, :publication_year)
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def render_404
    render file: "/public/404.html", status: 404
  end
end
