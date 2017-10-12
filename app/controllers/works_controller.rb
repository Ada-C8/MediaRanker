class WorksController < ApplicationController
  def index
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to works_path
    else
      # something els
    end
    # @work = Work.create(title: params[:work][:title], category: params[:work][:category], creator: params[:work][:creator], year: params[:work][:year], description: params[:work][:description])
  end

  def show
    @work = Work.find(params[:id])
  end
end

private
def work_params
  return params.require(:work).permit(:title, :category, :creator, :year, :description)
end
