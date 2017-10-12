class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show
    find_work_by_id
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:status] = :success
      flash[:notice] = "Successfully created #{@work.category} #{@work.title}"
      redirect_to work_path(@work.id)
    else
      flash.now[:status] = :failure
      flash.now[:notice] = "Failed to create a new work"
      flash.now[:details] = @work.errors.messages
      render :new, status: :bad_request
    end
  end

  def edit
    find_work_by_id
  end

  def update
    if find_work_by_id
      @work.update_attributes(work_params)
      if @work.save
        flash[:status] = :success
        flash[:notice] = "Successfully updated #{@work.category} #{@work.title}"
        redirect_to work_path(@work.id)
      else
        flash[:status] = :failure
        flash[:notice] = "Failed to update the work"
        render :edit, status: :bad_request
      end
    end
  end

    def destroy
      if find_work_by_id
        @work.destroy
        flash[:status] = :success
        flash[:notice] = "Successfully destroyed #{@work.category} #{@work.title}"
        redirect_to works_path
      end
    end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work_by_id
    @work = Work.find_by(id: params[:id])
    unless @work
      head :not_found
    end
    return @work
  end
end
