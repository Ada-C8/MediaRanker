class WorksController < ApplicationController

before_action :find_work_by_params, only: [:show, :edit, :destroy, :update]

  def root
    @movies = Work.top_ten("movie")
    @albums = Work.top_ten("album")
    @books = Work.top_ten("book")
    @top = Work.top_work
    unless @top
      @spotlight = "none"
    end
  end

  def index
    @works = Work.all
    @movies = Work.category_sort('movie')
    @books = Work.category_sort('book')
    @albums = Work.category_sort('album')

  end # index

  def show; end # show

  def new
    @work = Work.new
  end # new

  def create
    @work = Work.new(work_params)

    if save_flash(@work)
      redirect_to works_path
    else
      render :new, status: :bad_request
    end # if/else
  end # create

  def edit; end # edit

  def update
    # NOTE: don't need the if because we are using before_action
    # if find_work_by_params
      @work.update_attributes(work_params)
      if @work.save
        redirect_to work_path(@work)
        return
      else
        render :edit, status: :bad_request
        return
      end # if/else
    # end # else
  end # update

  def destroy
    @work.destroy
    redirect_to works_path
    return
  end # destroy

  def upvote
    @work = Work.find(params[:id])
    created = @work.votes.new(user_id: session[:logged_in_user], work_id: @work.id)
    if created.save
      flash[:status] = :successful
      flash[:message] = "Successfully upvoted!"
      redirect_to works_path
    elsif !(session[:logged_in_user])
      flash[:status] = :failure
      flash[:message] = "You must log in to do that"
      redirect_to works_path
    else
      flash[:status] = :failure
      flash[:message] = "user: has already voted for this work"
      redirect_to works_path
    end # if/else
  end # upvote

  private
  def find_work_by_params
    @work = Work.find_by(id: params[:id])
    # TODO: Dan told sarah that this isn't the right status code to use
    unless @work
      head :not_found
    end
    return @work
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end # work_params

end
