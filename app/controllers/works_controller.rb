class WorksController < ApplicationController
  before_action :find_work_by_params_id, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
  end

  def new
    @work = Work.new
    if params[:creator]
      @work.creator = params[:creator]
    end
  end

  def create
    @work = Work.new(work_params
    )
    if @work.save
      redirect_to works_path
    else
      render :new
    end
  end

  def show ; end

  def edit ; end

  def update ; end

  def destroy ; end

  private

  def work_params
    return params.require(:work).permit(:catergory, :title, :creator, :publication_year, :description)
  end

  def find_work_by_params_id
    @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
    end

  end
end
