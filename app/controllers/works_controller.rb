class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.works_by_category
  end

  def show
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
      flash.now[:failure] = "A problem occurred: Could not create #{@work.category}"
      render :new, status: :bad_request
    end
  end

  def edit
  end

  def update
    if @work.update_attributes(work_params)
      flash[:success] = "Successfully updated Media ID#{@work.id}!"
      redirect_to work_path(params[:id])
    else
      flash.now[:failure] = "A problem occurred: Could not update Media ID#{@work.id}"
      render :edit, status: :bad_request
    end
  end

  def destroy
    if (@work.votes.count == 0) && @work.destroy
      flash[:success] = "Successfully deleted Media ID#{@work.id}!"
      redirect_to works_path
    else
      flash[:failure] = "Cannot delete a work with votes!"
      redirect_to work_path(@work.id)
    end
  end

  def home
    @limited_works = Work.limit_by(Work.works_by_category, 10)

    @spotlight = Work.most_votes
  end

  private
  def find_work
    @work = Work.find_by(id: params[:id])
    render_404 unless @work
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
