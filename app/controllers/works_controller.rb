class WorksController < ApplicationController
  def index
    # @work = Work.find_by(id: params[:id])
    # @book_work = @work.where(category: "book").order(:title)
    # @movie_work = @work.where(category: "movie").order(:title)
    # @album_work = @work.where(category: "album").order(:title)

    @book_work = Work.where(category: "book").order(:title)
    @movie_work = Work.where(category: "movie").order(:title)
    @album_work = Work.where(category: "album").order(:title)

  end

  def show
    @work = Work.find_by(id: params[:id])

    unless @work
      render_404
    end

  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
  end

  def new
    @work = Work.new
  end

  def create
    @work= Work.new(work_params)

    if @work.save
      redirect_to works_path
    else
      render :new
    end
  end

  def destroy
  end
end

private

  def work_params
    return params.require(:work).permit(:category, :title,:creator,:pub_year,:description)
  end
