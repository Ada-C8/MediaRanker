class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def edit
    find_work_by_params_id
  end

  def update
    if find_work_by_params_id
      @work.update_attributes(work_params)
      if @work.save
        redirect_to work_path(@work.id)
        return
      else
        render :edit, status: :bad_request
      end
    end
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:status] = :success
      flash[:message] = "Sucessfully created a new work: #{@work.title}"
      redirect_to works_path
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create work"
      flash.now[:details] = @work.errors.messages
      render :new, status: :bad_request
    end
  end

  def show
    find_work_by_params_id
  end

  def destroy
    if find_work_by_params_id
      @work.destroy
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work_by_params_id
    @work = Work.find_by(id: params[:id])
    unless @work
      head :not_found
    end
    return @work
  end

end
