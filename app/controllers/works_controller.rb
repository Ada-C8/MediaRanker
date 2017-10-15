class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
    @albums = Work.where(category: "album").all.limit(10)
    @books = Work.where(category: "book").all.limit(10)
    @movies = Work.where(category: "movie").all.limit(10)
  end

  def show
    redirect_to works_path unless @work
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:status] = :success
      flash[:message] = "#{@work.category.capitalize} added successfully"
      redirect_to work_path(@work.id)
    else
      flash[:status] = :failure
      flash[:message] = "#{@work.category.capitalize} failed to be added"
      flash[:details] = @work.errors.messages
      render :new, status: :bad_request
    end
  end

  def edit
  end

  def update
    redirect_to work_path unless @work
    if @work.update_attributes work_params
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end

  def destroy
    @work.destroy
    redirect_to works_path
  end

  def votework
    @vote = Vote.create(work_id: params[:pass_id])
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    # redirect_to works_path unless @work
    @work = Work.find_by_id(params[:id])
  end
end
