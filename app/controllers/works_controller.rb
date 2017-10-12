class WorksController < ApplicationController
  def index
    @works = Work.all
    @types = ["movie", "book", "album"]
  end

  def show
    @work = Work.find(params[:id].to_i)
  end

  def create
    @work = Work.create work_params

    if @work.id != nil
      flash[:success] = "Work added successfully!"
      redirect_to works_path
    else
      flash[:error] = "Unable to add work"
      render :new
    end
  end

  def new
    @work = Work.new
  end

  def destroy
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id].to_s)
    redirect_to work_path unless @work

    @work.update_attributes work_params
    if @work.update_attributes work_params
      redirect_to works_path
    else
      render :edit
    end
  end

  private
  def work_params
    return params.require(:work).permit(:title, :description, :category, :year)
  end
end
