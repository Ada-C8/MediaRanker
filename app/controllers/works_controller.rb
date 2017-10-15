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
    if save_and_flash(@work)
      redirect_to works_path
    else
      render :new, status: :bad_request
    end
  end

  def show ; end

  def edit ; end

# "success" message from the #save_and_flash method is not working. however database is updated.
  def update
    @work.update_attributes(work_params)
    if save_and_flash(@work)
      redirect_to work_path(@work)
      return
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @work.destroy
    redirect_to works_path

  end

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
