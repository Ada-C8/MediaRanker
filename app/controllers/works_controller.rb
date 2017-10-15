class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update]
  #TODO setup work model method for sorting, etc (take out of controller)

  def index
    books = Work.where(category: "book")
    movies = Work.where(category: "movie")
    albums = Work.where(category: "album")

    @works = {Albums: albums, Books: books, Movies: movies}
  end

  def show
    render_404 unless @work
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    render_404 unless @work

    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}!"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "A problem occurred: Could not create #{@work.category}"
      render :new, status: :bad_request
    end
  end

  def edit
    render_404 unless @work
  end

  def update
    if @work.update_attributes(work_params)
      flash[:success] = "Successfully updated Media ID#{@work.id}!"
      redirect_to work_path(params[:id])
    else
      flash.now[:error] = "A problem occurred: Could not update Media ID#{@work.id}"
      render :edit, status: :bad_request
    end
  end

  def destroy
    redirect_back(fallback_location: works_path) if Work.find_by(id: params[:id]).destroy
  end

  def home #same as index with limit, how to do?
    books = Work.where(category: "book").joins(:votes).group('works.id').order('count(votes) DESC').limit(10)
    movies = Work.where(category: "movie").joins(:votes).group('works.id').order('count(votes) DESC').limit(10)
    albums = Work.where(category: "album").joins(:votes).group('works.id').order('count(votes) DESC').limit(10)

    @works = {Albums: albums, Books: books, Movies: movies}
  end

  private
  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
