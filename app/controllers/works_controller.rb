class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    # @work = Work.find_by
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(works_params)
  if @work.save
    redirect_to works_path
  else
    render :new
  end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def works_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
