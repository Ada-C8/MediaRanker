class WorksController < ApplicationController
  before_action :find_by_id, only: [:show, :edit, :update, :destroy]

  def index
    @works_by_category = {}
    Work::CATEGORIES.each do |cat|
    @works_by_category[cat] = Work.where(category: cat)
    end
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
      render :new, status: :bad_request
    end
  end

  def edit
    render_404 if @work.nil?
  end

  def update
    render_404 and return if @work.nil?

    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category}."
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "Couldn't update, please try again."
      render :edit, status: :bad_request
    end
  end

  def destroy
    @work.destroy
    redirect_to root_path
  end


  private

  def work_params
    params.require(:work).permit(:category, :title, :description, :creator, :publication_year)
  end

  def find_by_id
    @work = Work.find_by_id(params[:id])
  end

end
