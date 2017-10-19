class WorksController < ApplicationController

  def main
    user_id = session[:user_id]
    if user_id
      @user = User.find(user_id)
    end
    @movies = Work.top_ten('movie')
    @books = Work.top_ten('book')
    @albums = Work.top_ten('album')
    puts @user
    @spotlight = Work.all.order(votes_count: :desc).first
  end

  def index
    # view all works
    @movies = Work.where(category: 'movie')
    @books = Work.where(category: 'book')
    @albums = Work.where(category: 'album')
  end

  def new
    @work = Work.new
  end

  def create
    # POST new work
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work.id)
    else
      render new_work_path
    end
  end

  def show
    # individual work
    @work = Work.find(params[:id])
  end

  def edit
    # GET changes
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    if @work.update(work_params)
      redirect_to works_path
    else
      render :edit, status: :bad_request
    end
    # POST changes
  end

  def destroy
    # DELETE
    @work = Work.find(params[:id])
    @work.destroy
    redirect_to works_path
  end

  def upvote
    # vote on works
    user_id = session[:user_id]
    if user_id
      user = User.find(user_id)
      upvoted, message = user.upvote(params[:id])
      unless upvoted
        flash[:status] = :error
        flash[:result_text] = message
      end
    end
    redirect_to work_path(params[:id])
  end

  private

  def work_params
    params.require(:work).permit(:title, :category, :creator, :description, :publication_year)
  end
end
