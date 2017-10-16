class WorksController < ApplicationController
  before_action :find_work_by_params_id, only: [:show, :edit, :update, :destroy]


  def index
    if params[:work_id]
      @work = Work.find_by(id: params[:work_id])
      unless @work
        head :not_found
      end
    else
      @works = Work.all
    end
  end

  def show; end

  def new
    @work = Work.new
  end

  def edit; end

  def create
    @work= Work.new(work_params)
    if save_and_flash(@work)
      redirect_to work_path(@work)
    else
      render :new, status: :bad_request
    end
  end

  def update
    @work.update_attributes(work_params)
    if save_and_flash(@work)
      redirect_to work_path(@work)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy

    unless find_work_by_params_id
      votes = Vote.where(work_id: @work.id)
      votes.each do |vote|
        vote.destroy
      end
    end

     if @work.destroy
      flash.now[:status] = :success
      flash.now[:message] = "Successfully destroyed #{@work.category} #{@work.id}"
      redirect_to root_path
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Problem encountered when attempting to destroy #{@work.category} #{@work.id}"
    end
  end

  private
  def work_params
    return params.require(:work).permit(:title, :category, :publication_year, :creator)
  end

  def find_work_by_params_id
    @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
    end
  end

end
