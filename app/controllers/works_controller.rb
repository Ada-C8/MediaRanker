class WorksController < ApplicationController
  before_action :find_work_by_params_id, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Work.where(category: "movie")
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
  end

  def show ; end

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

  def edit ; end

  def update
    # if find_work_by_params_id
    @work.update_attributes(work_params)
    if save_and_flash(@work)
      redirect_to work_path(@work)
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    # if find_work_by_params_id
    @work.destroy
    redirect_to works_path
    # end
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
    # Don't need a return b/c we're no longer calling this directly
    # and if there's an error we won't even get into our controller action
    # return @work
  end
end
