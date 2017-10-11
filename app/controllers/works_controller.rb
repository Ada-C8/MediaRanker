class WorksController < ApplicationController
  def index
    @works = Work.all#.order('title asc')
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to works_path
    else
      render :new, status: :bad_request
    end

  end

  def new
    @work = Work.new
  end

  def edit
    find_book_by_params_id
  end

  def show
    find_book_by_params_id
  end

  def update
    if find_book_by_params_id

      @work.update_attributes(work_params)
      if @work.save
        redirect_to(work_path(@work))
      else
        render :edit, status: :bad_request
      end
    end
  end

  def destroy
    @work = Work.find(params[:id])
    @work.destroy

    redirect_to works_path
  end

private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_book_by_params_id
    @work = Work.find_by(id: params[:id])
    head :not_found unless @work
    return @work
  end
end
