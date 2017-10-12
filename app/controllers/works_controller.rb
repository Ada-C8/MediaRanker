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
      return redirect_to work_path(@work.id)
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create #{@work.category}."
      flash.now[:details] = @work.errors.messages
      return render :new, status: :bad_request
    end
  end

  def edit
    find_work_by_params(params)
  end

  def update
    @work = Work.find_by(id: params[:id])
    # binding.pry
    if @work
      result = @work.update(work_params)
      # binding.pry
      if result
        flash[:status] = :success
        flash[:message] = "Created #{@work.category} #{@work.title}."
        return redirect_to works_path
      else
        flash.now[:status] = :failure
        flash.now[:message] = "Failed to create #{@work.category}."
        flash.now[:details] = @work.errors.messages
        return render :edit, status: :bad_request
      end
    else
      return head :not_found
    end
  end

  def destroy
    # find_work_by_params(params)
    @work = Work.find_by(id: params[:id])

    if @work
      @work.destroy
      flash[:status] = :success
      flash[:message] = "Deleted #{@work.category} #{@work.title}."
      return redirect_to works_path
    else
      flash[:status] = :failure
      flash[:message] = "Unable to find work to delete."
      return redirect_to works_path
    end
  end

  def upvote
    vote = Vote.new(user_id: session[:user]['id'], work_id: params[:id])

    result = vote.save

    if result
      return redirect_back(fallback_location: works_path)
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
      return head :not_found
    end
  end
end
