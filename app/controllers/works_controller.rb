class WorksController < ApplicationController

  #TODO: dry this up.
  def index
    @works = Work.all
    # @albums_sorted_by_votes = Work.work_sorted_by_votes("album")
    # @books_sorted_by_votes = Work.work_sorted_by_votes("book")
    # @movies_sorted_by_votes = Work.work_sorted_by_votes("movie")
    @albums_sorted_by_votes = Work.albums_sorted_by_votes
    @books_sorted_by_votes = Work.books_sorted_by_votes
    @movies_sorted_by_votes = Work.movies_sorted_by_votes
  end

  def new
    @work = Work.new
  end

  def edit
    find_work_by_params_id
  end

  def update
    if find_work_by_params_id
      @work.update_attributes(work_params)
      if @work.save
        flash[:status] = :success
        flash[:message] = "Successfully edited: #{@work.title}"
        redirect_to work_path(@work.id)
        return
      else
        flash.now[:status] = :failure
        flash.now[:message] = "Failed to edit work"
        flash.now[:details] = @work.errors.messages
        render :edit, status: :bad_request
      end
    end
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:status] = :success
      flash[:message] = "Successfully created a new work: #{@work.title}"
      redirect_to works_path
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create work"
      flash.now[:details] = @work.errors.messages
      render :new, status: :bad_request
    end
  end

  def show
    find_work_by_params_id
  end

  def destroy
    if find_work_by_params_id
      @work.destroy
      flash[:status] = :success
      flash[:message] = "Successfully deleted: #{@work.title}"
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work_by_params_id
    @work = Work.find_by(id: params[:id])
    unless @work
      head :not_found
    end
    return @work
  end

end
