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
    @work = Work.new(work_params)
    if save_and_flash(@work)
      redirect_to works_path
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
    #Fails test if I take the if loop out, but I don't think I should need it given the before_action block
      @work.destroy
      redirect_to works_path
  end

  private
  def work_params
    return params.require(:work).permit(:title)
  end

  def find_work_by_params_id
    @work = Work.find_by(id: params[:id])
    unless @work
      head :not_found
    end
  end

end
