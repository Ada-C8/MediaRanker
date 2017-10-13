class WorksController < ApplicationController
  def home
    # @media = media_hash(top_ten: true)
    # @media = Work.works_by_type_hash
    # @media = { "albums": Work.works_of_type("album", top_ten: true),
    #             "books": Work.works_of_type("book", top_ten: true),
    #             "movies": Work.works_of_type("movie", top_ten: true) }
    media_hash = Work.works_by_type_hash
    @media = Work.top_ten(media_hash)

    # works = Work.left_outer_joins(:votes).distinct.select('works.*, COUNT(votes.*) AS num_votes').group('works.id').order('num_votes DESC')
    @spotlight = Work.spotlight
  end

  def index
    #@works = Work.left_outer_joins(:votes).distinct.select('works.*, COUNT(votes.*) AS num_votes').group('works.id').order('num_votes DESC')
    @media = Work.works_by_type_hash
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
      flash[:success] = "Successfully created #{@work.category.name} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      # puts "error message"  DEBUGGING
      # puts @work.errors.inspect
      flash.now[:error] = "A problem occurred: Could not create #{@work.category.name}"
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
      flash.now[:error] = "A problem occurred: Could not update #{@work.category.name}"
      render :edit
    end

  end

  def destroy
    @work = Work.find_by(id: params[:id])
    @work.destroy

    if @work.destroyed?
      flash[:success] = "Successfully destroyed #{@work.category.name} #{@work.id}"
      redirect_to root_path
    else
      flash.now[:error] = "Unable to delete #{@work.category.name} #{@work.id}"
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :creator, :publication_year, :description, :category_id)
  end

  def media_hash(top_ten = true)
    albums = Work.left_outer_joins(:votes).where(category_id: Category.find_by(name: "album")).distinct.select('works.*, COUNT(votes.*) AS num_votes').group('works.id').order('num_votes DESC')

    movies = Work.left_outer_joins(:votes).where(category_id: Category.find_by(name: "movie")).distinct.select('works.*, COUNT(votes.*) AS num_votes').group('works.id').order('num_votes DESC')

    books = Work.left_outer_joins(:votes).where(category_id: Category.find_by(name: "book")).distinct.select('works.*, COUNT(votes.*) AS num_votes').group('works.id').order('num_votes DESC')

    if top_ten
      return {"albums": albums[0...10], "movies": movies[0...10], "books": books[0...10]}
    else
      return {"albums": albums, "movies": movies, "books": books}
    end
  end

end
