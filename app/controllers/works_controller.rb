class WorksController < ApplicationController
  def index
    @albums = Work.where("category = 'album'")
    @books = Work.where("category = 'book'")
    @movies = Work.where("category = 'movie'")

  end

  def homepage
    @albums = Work.where("category = 'album'")
    @books = Work.where("category = 'book'")
    @movies = Work.where("category = 'movie'")
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work == nil
      redirect_to "/404.html"
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_parameters)
    if @work.save
      flash[:success] = "Work was successfully saved."
      redirect_to @work
    else
      flash.now[:error] = "Work was unsuccessfully saved."
      render :new
    end
  end

  def destroy
    work = Work.find_by(id: params[:id].to_i)
    if work
      work.destroy
      flash[:success] = "Work ##{work.id} was successfully deleted."
    else
      flash[:error] = "Work cannot be deleted."
    end
    redirect_to root_path
  end

  def edit
    @work = Work.find_by(id: params[:id].to_i)
    unless @work
      flash[:error] = "Work does not exist."
      redirect_to root_path
    end

  end

  def update
    @work = Work.find_by(id: params[:id].to_i)
    if @work.update_attributes work_parameters
      redirect_to @work
    else
      flash.now[:error] = "Work was unsuccessfully edited."
      render :new
    end
  end

  def upvote
    work = Work.find_by(id: params[:id].to_i)
    if session[:user] == nil # if user is already logged in
      flash[:error] = "You must be logged in to upvote"
    elsif work.users.find_by(id: session[:user]["id"]) != nil # if the user already upvoted
      flash[:error] = "User #{session[:user]["username"]} already upvoted"
    else # user is logged in
      vote = Vote.new
      vote.work_id = params[:id]
      vote.user_id = session[:user]["id"]
      vote.save
      flash[:success] = "Successfully upvoted!"
    end
    redirect_to work
  end

  private

  def work_parameters
    params.require(:work).permit(:title, :category, :creator, :description, :publication_year)
  end

end
