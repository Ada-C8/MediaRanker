class WorksController < ApplicationController
  before_action :find_by_id, only: [:show, :edit, :update, :destroy]

  def index

  end

  def show
    render_404 if @work.nil?
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Added successfully"
      redirect_to root_path
    else
      flash.now[:error] = "Couldn't add, try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category}."
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "Couldn't update, please try again."
      render :edit
    end
  end

  def destroy

  end


  private

  def work_params
    params.require(:work).permit(:category, :title, :description, :creator, :publication_year)
  end

  def find_by_id
    @work = Work.find_by_id(params[:id])
  end

end
