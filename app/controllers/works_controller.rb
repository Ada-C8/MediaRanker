class WorksController < ApplicationController

  def home
    @homepage = true
  end

  def index
    @works = Work.order(:category)
  end

  def show
    @work = Work.find_by(id: params[:id])
  end

  def new
  end

  def create
  end

  def edit
    @work = Work.find_by(id: params[:id])
    unless @work
      redirect_to works_path
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    result = @work.update({category: params[:work][:category], title: params[:work][:title], creator: params[:work][:creator], publication_year: params[:work][:publication_year], description: params[:work][:description]})
    if result
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end

  def destroy
  end






  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
