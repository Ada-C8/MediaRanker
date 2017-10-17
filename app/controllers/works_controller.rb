class WorksController < ApplicationController
  before_action :find_work_by_params_id, only: [:show, :edit, :update, :destroy]

  def index
    all_work = Work.all_with_vote_count
    @movies = all_work.where(category: "movie")
    @books = all_work.where(category: "book")
    @albums = all_work.where(category: "album")
  end

  def show ; end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:status] = :success
      flash[:message] = "Successfully created work #{@work.title}"
      redirect_to work_path(@work)
    else
      flash[:status] = :failure
      flash[:message] = "Failed to created work"
      flash[:details] = @work.errors.messages
      render :new, status: :bad_request
    end
  end

  def edit ; end

  def update
    # if find_work_by_params_id
    @work.update_attributes(work_params)
    if save_and_flash(@work)
      redirect_to work_path(@work)
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    # if find_work_by_params_id
    @work.destroy
    redirect_to works_path
    # end
  end

  def upvote
    user_id = session[:logged_in_user]
    work_id = params[:id]
    if !user_id
      flash[:status] = :failure
      flash[:message] = "You must log in to do that"
    elsif
      Vote.find_by_user_id_and_work_id(user_id,work_id)
      flash[:status] = :failure
      flash[:message] = "Could not upvote. User has already voted for this work"
    elsif
      vote = Vote.new
      vote.user_id = user_id
      vote.work_id = work_id
      vote.save
      flash[:status] = :success
      flash[:message] = "Successfully upvoted #{user_id}/#{work_id} "
    end
    redirect_back fallback_location:works_path
  end
private

  def work_params
    return params.require(:work).permit(:title, :creator, :publication_year, :category, :description)
  end


  def find_work_by_params_id
    @work = Work.find_by(id: params[:id])
    # head :not_found and return if @work.nil?
    unless @work
      head :not_found
    end
    # Don't need a return b/c we're no longer calling this directly
    # and if there's an error we won't even get into our controller action
    # return @work
  end
end
