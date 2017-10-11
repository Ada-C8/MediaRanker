class WorksController < ApplicationController
  def index
    @works = Work.all

    albums = Work.where(category_id: Category.find_by(name: "album"))[0...10]
    movies = Work.where(category_id: Category.find_by(name: "movie"))[0...10]
    books = Work.where(category_id: Category.find_by(name: "book"))[0...10]

    @media = { "albums": albums, "movies": movies, "books": books }
  end

  def show
    @work = Work.find_by(id: params[:id])

    unless @work
      flash[:notice] = "Item not found"
      redirect_to root_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:notice] = "Successfully created #{work.category.name}"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    unless @work
      flash[:notice] = "Item not found"
      redirect_to root_path
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    unless @work
      flash[:notice] = "Item not found"
      redirect_to works_path
    end

    if @work.update_attributes(work_params)
      flash[:notice] = "#{@work.category.name} successfully updated"
      redirect_to work_path
    else
      render :edit
    end

  end

  def destroy
    @work = Work.find_by(id: params[:id])
    @work.destroy

    redirect_to root_path
  end

  private

  def work_params
    return params.require(:work).permit(:category_id, :title, :creator, :publication_year, :description)
  end
end
