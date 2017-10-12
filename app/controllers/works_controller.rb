class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])
    unless @work
      head :not_found
    end
    return @work
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:notice] = "Successfully created #{@work.category} #{@work.title}"
      redirect_to work_path(@work.id)
    else
      render :new
    end
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    updated = @work.update(work_params)

    if updated
      flash[:notice] = "Successfully updated #{@work.category} #{@work.title}"
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end

    def destroy
      @work = Work.find(params[:id])
      @work.destroy
      flash[:notice] = "Successfully destroyed #{@work.category} #{@work.title}"
      redirect_to works_path
    end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
