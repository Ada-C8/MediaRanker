class WorksController < ApplicationController
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
  end # index

  def show
  find_work_by_params
  end # show

  def new
    @work = Work.new
  end # new

  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to works_path
    else
      render :new, status: :bad_request
    end # if/else
  end # create

  def edit
    find_work_by_params
  end # edit

  def update
    if find_work_by_params
      @work.update_attributes(work_params)
      if @work.save
        redirect_to work_path(@work)
        return
      else
        render :edit, status: :bad_request
        return
      end # if/else
    end # else
  end # update

  def destroy
    if find_work_by_params
      @work.destroy
      redirect_to works_path
      return
    end # if
  end # destroy

  def upvote
    @work = Work.find(params[:id])
    created = @work.votes.new(user_id: session[:logged_in_user], work_id: @work.id)
    if created.save
      flash[:status] = :successful
      flash[:message] = "Successfully upvoted!"
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
