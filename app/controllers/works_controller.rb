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
    @movies = Work.where(category: "movie")
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
    unless @works
      head :not_found
    end
  end

  def show
    find_work
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
    if find_work
      @work.destroy
      redirect_to works_path
    else
      #error message
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
