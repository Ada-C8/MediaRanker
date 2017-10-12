class WorksController < ApplicationController
  def index
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")
    @books = Work.where(category: "book")
  end

  def show
    find_work_by_params(params)
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    result = @work.save

    if result
      flash[:status] = :success
      flash[:message] = "Created #{@work.category} #{@work.title}."
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create #{@work.category}."
      flash.now[:details] = @work.errors.messages
      render new_work_path
      return
    end
  end

  def edit
    find_work_by_params(params)
  end

  def update
    find_work_by_params(params)
    result = @work.update(work_params)

    if result
      flash[:status] = :success
      flash[:message] = "Updated #{@work.category} #{@work.title}."
      redirect_to work_path(params[:id])
      return
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to update #{@work.category}."
      flash.now[:details] = @work.errors.messages
      render new_work_path
      return
    end
  end

  def destroy
    find_work_by_params(params)
    result = @work.destroy

    if result
      flash[:status] = :success
      flash[:message] = "Deleted #{@work.category} #{@work.title}."
      redirect_to works_path
      return
    else
      #error message
    end
  end

  def upvote
    vote = Vote.new(user_id: session[:user]['id'], work_id: params[:id])

    result = vote.save

    if result
      return render works_path
    else
      return redirect_back(fallback_location: works_path)
    end
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work_by_params(params)
    @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
      return
    end
  end
end
