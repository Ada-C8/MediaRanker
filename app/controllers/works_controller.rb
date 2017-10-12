class WorksController < ApplicationController

  def index
    # if params[:author_id]
    # @books = Author.find(params[:author_id]).books
    # else
    # @books = Book.all
    # end

    # if ##### do I want an if statement??
    # else
    # head :not_found
    # end

    @works = Work.all
    @movies = Work.where(category: "movie").sort_by{|work| -work.votes.count}
    @books = Work.where(category: "book").sort_by{|work| -work.votes.count}
    @albums = Work.where(category: "album").sort_by{|work| -work.votes.count}
    # order("vote DESC").first
    unless @works
      # how to trigger this and make this actually occur?
      head :not_found
    end
  end

  def show
    find_work
    @votes = Vote.where(work_id: params[:id])
  end

  def new
    @work = Work.new
  end

  def create

    # think about logic for only creating work if user is logged in
    # dan's destroy method works in books_controller

    # current_user = nil
    # if session[:logged_in_user]
    #   current_user = User.find_by(id: session[:logged_in_user])
    # end
    # else
    #   flash[:statu] = :failure
    #   flash[:message] = "You must be logged in to do that."
    #   redirect_to works_path
    #   return
    # end

    @work = Work.new(
    work_params
    )
    if @work.save
      flash[:status] = :success
      flash[:message] = "Successfully created work #{@work.id}"
      redirect_to works_path
    else
      flash[:status] = :failure
      flash[:message] = "Failed to created work #{@work.id}"
      flash[:details] = @work.errors.messages
      render :new, status: :bad_request
    end
  end

  def edit
    find_work
  end

  def update
    if find_work
      @work.update_attributes(work_params)
      if @work.save
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
    if find_work
      @work.destroy
      flash[:status] = :success
      flash[:message] = "Successfully deleted!"
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
    unless @work
      head :not_found
    else
      return @work
    end
  end

end
