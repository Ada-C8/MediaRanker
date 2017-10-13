class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def create
    @new_work = Work.new work_params

    if @new_work.save
      flash[:success] = "Successfully created #{@new_work.category} #{@new_work.id}"
      redirect_to work_path(@new_work.id)
    else
      render :new
    end
  end

  def new
    @work = Work.new
  end

  def edit
    @work = Work.find_by(id: params[:id])

    redirect_to root_path unless @work
  end

  def show
    @work = Work.find_by(id: params[:id])
    # @votes = @work.votes.order(:created_at)
  end

  def update
    @work = Work.find_by(id: params[:id])
    redirect_to root_path unless @work

    if @work.update_attributes work_params
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end

  def destroy
    @work= Work.find_by(id: params[:id]).destroy

    redirect_to root_path
  end

  def main
    @works= Work.all
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end


end
