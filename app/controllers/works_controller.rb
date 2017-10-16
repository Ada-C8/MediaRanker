class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update]

  def index
    @works = Work.works_by_category
  end

  def show
    render_404 unless @work
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    render_404 unless @work

    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}!"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "A problem occurred: Could not create #{@work.category}"
      render :new, status: :bad_request
    end
  end

  def edit
    render_404 unless @work
  end

  def update
    if @work.update_attributes(work_params)
      flash[:success] = "Successfully updated Media ID#{@work.id}!"
      redirect_to work_path(params[:id])
    else
      flash.now[:error] = "A problem occurred: Could not update Media ID#{@work.id}"
      render :edit, status: :bad_request
    end
  end

  def destroy
    redirect_back(fallback_location: works_path) if Work.find_by(id: params[:id]).destroy
  end

  def home
    @limited_works = Work.limit_by(Work.works_by_category, 10)

    @spotlight = Work.most_votes
  end

  private
  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
