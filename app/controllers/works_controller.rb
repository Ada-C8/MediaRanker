class WorksController < ApplicationController
before_action :find_work, only: [:show, :edit, :update, :destroy]
  def index
    @works = Work.all
    @movies = Work.where(category: "movie").sort_by{|work| -work.votes.count}
    @books = Work.where(category: "book").sort_by{|work| -work.votes.count}
    @albums = Work.where(category: "album").sort_by{|work| -work.votes.count}
    unless @works
      # how to trigger this and make this actually occur?
      head :not_found
    end
  end

  def show ; end
    # @votes = Vote.where(work_id: params[:id])
    
  def new
    @work = Work.new
  end

  def create
    @work = Work.new(
    work_params
    )
    if save_and_flash(@work)
      redirect_to works_path
    else
      render :new, status: :bad_request
    end
  end

  def edit ; end

  def update
    if find_work
      @work.update_attributes(work_params)
      if save_and_flash(@work)
        redirect_to work_path(@work)
        return
      else
        render :edit, status: :bad_request
        return
      end
    end
  end

  def destroy
    current_user = nil
    #am I actually using this if statement?
    if session[:user_id]
      current_user = User.find_by(id: session[:user_id])
    end
    if current_user != @work.creator
      flash[:status] = :failure
      flash[:message] = "Only the creator can destroy it!"
      redirect_to works_path
      return
    end

    # if find_work
      @work.destroy
      flash[:status] = :success
      flash[:message] = "Successfully deleted!"
      redirect_to works_path
    # end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
    unless @work
      head :not_found
    # else
    #   return @work
    end
  end

end
