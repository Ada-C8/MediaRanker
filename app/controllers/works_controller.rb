class WorksController < ApplicationController
  #add a control action with login name and status



  def index
    # @work = Work.find_by(id: params[:id])
    # @book_work = @work.where(category: "book").order(:title)
    # @movie_work = @work.where(category: "movie").order(:title)
    # @album_work = @work.where(category: "album").order(:title)
    if params[:work_id]
      @book_work = Work.where(category: "book").order(:title)
      @movie_work = Work.where(category: "movie").order(:title)
      @album_work = Work.where(category: "album").order(:title)
      if @book_work.empty? || @movie_work.empty? || @album_work.empty?
        render :not_found
      end
    end
  end

  def show
    @work = Work.find_by(id: params[:id])

    unless @work
      render_404
    end

  end

  def edit
    @work = Work.find_by(id: params[:id])

    unless @work
      redirect_to works_path
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.update_attributes(work_params)
      redirect_to work_path(@work.id)
    else
      render :edit
    end
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
