class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    # @work = Work.create(title: params[:work][:title], category: params[:work][:category], creator: params[:work][:creator], year: params[:work][:year], description: params[:work][:description])
  end

  def show
    @work = Work.find(params[:id])
  end
end

private
def work_params
  return params.require(:work).permit(:creator, :year, :description)
end
