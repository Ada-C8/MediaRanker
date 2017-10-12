class WorksController < ApplicationController
  def index
    @works = Work.all
    @types = ["movies", "books", "music"]
  end

  def show
    @work = Work.find(params[:id].to_i)
  end

  def create
    @work.create work_params

    if @work.id != nil
      flash[:success] = "Work added successfully!"
      redirect_to works_path
    else
      render :new
    end

  end

  def new
    @work = Work.new
  end

  def destroy
  end

  def edit

  end

  def update
  end

  private
  def work_params
    return params.require(:work).permit(:title, :description, :category)
  end
end
