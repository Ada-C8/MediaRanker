class WorksController < ApplicationController
  #filter process
  before_action :find_work_by_params_id, only: [:show, :edit, :update, :destroy]

  def index
    #rework me please...
    @works = Work.all
    @movies = Work.where(category: "movie").sort_by{|work| -work.votes.count}
    @books = Work.where(category: "book").sort_by{|work| -work.votes.count}
    @albums = Work.where(category: "album").sort_by{|work| -work.votes.count}
    unless @works
      head :bad_request #not sure this is correct status code need clarification
    end

  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    # message = "Successfully created #{@work.category} #{@work.id}"
    if save_and_flash(@work, "created", "create")
      redirect_to works_path
    else
      render :new, status: :bad_request
    end
  end

  def show ; end

  def edit ; end

  def update
    @work.update_attributes(work_params)
    if save_and_flash(@work, "updated", "update")
      redirect_to work_path(@work)
      return
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    # we don't need this here because it is getting checked in controller filter above
    # if find_work_by_params_id
      @work.destroy
      redirect_to works_path
      flash[:status] = :success
      flash[:message] = "Successfully deleted!"
    # end
  end

private
  def find_work_by_params_id
    @work = Work.find_by(id: params[:id])
    unless @work
      head :not_found
    end
  end

  def work_params
    # params are what fields the user is allowed to set
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  end
end
