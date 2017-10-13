class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])
    unless @work
      head :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Successfully added #{@work.title}"
      redirect_to works_path
    else
      flash.now[:error] = "#{@work.title} not added successfully"
      render :new, status: :bad_request
    end
  end

  def edit
    find_work_by_params_id
  end

  def update
    if find_work_by_params_id
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
    if find_work_by_params_id
      @work.destroy
      redirect_to works_path
      return
    else
      head :not_found
    end

  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work_by_params_id
    # can add the repeated show and edit code here to try it up some more
    @work = Work.find_by(id: params[:id])
    unless @work
      head :not_found
    end
    return @work
  end
end
