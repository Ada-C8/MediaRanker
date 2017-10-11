class WorksController < ApplicationController
  def home
    @works = Work.all
    @media = media_hash(true)
    # get first work until Vote model added
    @spotlight = Work.first
  end

  def index
    @works = Work.all
    @media = media_hash(false)
  end

  def show
    @work = Work.find_by(id: params[:id])

    unless @work
      render_404
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      #flash[:success] = "Successfully created #{@work.category.name}"
      redirect_to root_path
    else
      puts "error message"
      puts @work.errors.inspect
      flash[:error] = "ERROR"
      render :new
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    render_404 unless @work
  end

  def update
    @work = Work.find_by(id: params[:id])

    unless @work
      render_404 unless @work
      return
    end

    if @work.update_attributes work_params
      flash[:success] = "Successfully updated #{@work.category.name}"
      redirect_to root_path
    else
      render :edit
    end

  end

  def destroy
    @work = Work.find_by(id: params[:id])
    @work.destroy

    if @work.destroyed?
      flash[:success] = "Successfully deleted #{@work.category.name}"
      redirect_to root_path
    else
      flash[:error] = "Unable to delete #{@work.category.name}"
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :creator, :publication_year, :description, :category_id)
  end

  def media_hash(top_ten = true)
    albums = Work.where(category_id: Category.find_by(name: "album"))
    movies = Work.where(category_id: Category.find_by(name: "movie"))
    books = Work.where(category_id: Category.find_by(name: "book"))

    if top_ten
      return {"albums": albums[0...10], "movies": movies[0...10], "books": books[0...10]}
    else
      return {"albums": albums, "movies": movies, "books": books}
    end
  end
end
