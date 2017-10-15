class WorksController < ApplicationController
  before_action :find_work_by_params_id, only:[:show, :update, :destroy]

  def index
    @works = Work.all
  end

  def show
    # find_work_by_params_id
  end


  def new
    @work = Work.new
  end


  def edit
    find_work_by_params_id
  end

  def create
    strong_params = work_params
    @work = Work.new(strong_params)
    if save_and_flash(@work)
      redirect_to works_path
    else
      render :new, status: :bad_request
    end
  end

  def update
    strong_params = work_params
    # find_work_by_params_id
    unless @status == true
      @work.update_attributes(strong_params)
      if save_and_flash(@work)
        redirect_to work_path(params[:id])
        return
      else
        render :edit, status: :bad_request
        return
      end
    end
  end

  def destroy
    # find_work_by_params_id
    unless @status == true
      work = Work.find(params[:id])
      votes = Vote.where(work_id: work.id)
      votes.each do |vote|
        vote.destroy
      end
      work.destroy
      redirect_to root_path
      return
    end
  end

private
  def work_params
    return params.require(:work).permit(:title, :category, :creator, :pub_year, :description)
  end

  def find_work_by_params_id
    @work = Work.find_by(id: params[:id])
    unless @work
      head :not_found
      @status = true
    end
  end
end
