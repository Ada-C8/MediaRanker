class WorksController < ApplicationController

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

  def show
    find_work_by_params_id
  end

  def new
    @work = Work.new
  end

  def edit
    find_work_by_params_id
  end

  def create
    @work = Work.new(work_params)
    @work.save
    if @work.save
      redirect_to works_path
    else
      render :new
    end
  end

  def update
    @work =Work.find(params[:id])
    @work.update_attributes(driver_params)
    @work.save

    redirect_to works_path
  end

  def destroy
    @book = find_work_by_params_id
    if @book
      @book.destroy
    else
      #
    end
    redirect_to books_path
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
    return @work
  end




end
