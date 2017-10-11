class WorksController < ApplicationController
  def index
    books = Work.where(category: "book")
    movies = Work.where(category: "movie")
    albums = Work.where(category: "album")

    @works = {Albums: albums, Books: books, Movies: movies}
  end

  def show
    @work = Work.find_by(id: params[:id])
    render_404 unless @work
  end

  def new
  end

  def create
  end

  def edit
    @work = Work.find_by(id: params[:id])
    render_404 if @work == nil
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.update_attributes(work_params)
      flash[:success] = "Successfully updated Media ID#{@work.id}!"
      redirect_to work_path(params[:id])
    else
      flash.now[:error] = "A problem occurred: Could not update Media ID#{@work.id}"
      render :edit
    end
  end

  def destroy
  end

  def home #same as index with limit, how to do?
    #TODO add sort method by vote
    books = Work.where(category: "book").limit(10)
    movies = Work.where(category: "movie").limit(10)
    albums = Work.where(category: "album").limit(10)

    @works = {Albums: albums, Books: books, Movies: movies}
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
