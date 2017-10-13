class WorksController < ApplicationController
  def index
    # @works = Work.all
  end

  def show
    find_work_by_id
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    # @work.creator = "Unknown" if @work.creator.nil?

    if @work.creator == nil
      @work.creator = "Unknown"
    end

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
        render :edit, status: :bad_request
        return
      end
    end

  end

  def destroy
    p "heere 4"
    if find_work_by_id
      p "heere"
      @work.destroy
      redirect_to works_path
      return
    end
  end

  private

  def work_params
    params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
    # if params[:category] == nil
    #   params[:category] = "Unknown"
    # end
  end

  def find_work_by_id
    @work = Work.find_by(id: params[:id])
    unless @work
      head :not_found
    end
    return @work
  end

end
