class WorksController < ApplicationController
  def index
    @movies = Work.where(category: "movie")
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
  end

  def show
    @work = Work.find(params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to works_path
    else
      render :new
    end
  end

  # def edit
  #   @work = Work.find(params[:id])
  # end

  # def update
  #   @work = Work.find(params[:id])
  #   result = @work.update_attributes(work_params)
  #
  #   if result
  #     redirect_to work_path(params[:id])
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   work = Work.find(params[:id])
  #   result = work.destroy
  #   if result
  #     redirect_to works_path
  #   else
  #     redirect_to work_path(params[:id])
  #   end
  # end

  private

  def work_params
    return params.require(:work).permit(:title, :creator, :publication_year, :category, :description)
  end


end
