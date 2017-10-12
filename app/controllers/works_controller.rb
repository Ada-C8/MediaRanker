class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    find_work_by_id
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to works_path
      return
    else
      render :new, status: :bad_request
      return
    end
  end

  def edit
    find_work_by_id
  end

  def update
    if find_work_by_id
      @work.update_attributes(work_params)
      if @work.save
        redirect_to work_path(@work)
        return
      else
        render edit, status: :bad_request
        return
      end
    end

  end

  def destroy

  end

  private

  def work_params
    params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  end

  def find_work_by_id
    @work = work.find(params[:id])
    unless @work
      head :not_found
    end
  end

end
