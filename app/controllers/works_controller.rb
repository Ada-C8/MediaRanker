class WorksController < ApplicationController
  before_action :find_work_by_id, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
  end

  def show ; end

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

  def edit ; end

  def update
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

    def destroy
      @work.destroy
      flash[:status] = :success
      flash[:notice] = "Successfully destroyed #{@work.category} #{@work.title}"
      redirect_to works_path
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
