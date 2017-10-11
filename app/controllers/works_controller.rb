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
    unless @work
      head :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(
    work_params
    )
    if @work.save
      flash[:status] = :success
      flash[:message] = "Successfully created work #{work.id}"
      redirect_to works_path
    else
      flash[:status] = :failure
      flash[:message] = "Failed to created work #{work.id}"
      flash[:details] = @work.error.messages
      render :new, status: :bad_request
    end
  end

  def edit
    find_work
    unless @work
      head :not_found
    end
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
    @work = Work.find(params[:id])
    if @work.destroy
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
