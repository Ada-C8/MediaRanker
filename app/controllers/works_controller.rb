class WorksController < ApplicationController
  def index
    @movies = Work.where(category: "movie")
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
  end

  def show
    find_work_by_params_id
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to works_path
    else
      render :new, status: :bad_request
    end
  end

  def edit
    find_work_by_params_id
  end

  def update
    if find_work_by_params_id
      result = @work.update_attributes(work_params)

      if result
        redirect_to work_path(params[:id])
      else
        render :edit, status: :bad_request
      end
    end
  end

  def destroy
    if find_work_by_params_id
      @work.destroy
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :creator, :publication_year, :category, :description)
  end

  def find_work_by_params_id
    @work = Work.find_by(id: params[:id])
    # head :not_found and return if @work.nil?
    unless @work
      head :not_found
    end
    return @work
  end
end
