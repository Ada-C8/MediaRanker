class WorksController < ApplicationController
  #add a control action with login name and status

  def home
    # if params[:work_id]
      # @book_work = Work.where(category: "book").limit(10)
      # @movie_work = Work.where(category: "movie").limit(10)
      # @album_work = Work.where(category: "album").limit(10)
      # if @book_work.empty? || @movie_work.empty? || @album_work.empty?
      #   render :not_found
      # end
    # end
    @votes = Vote.all
    @works = Work.all

    @book_votes = Hash.new(@works.where(category: "book") => 0)
    @movie_votes = Hash.new(@works.where(category: "movie") => 0)
    @album_votes = Hash.new(@works.where(category: "album") => 0)

    @votes.each do |vote|
      @works.each do |work|
        if work.category == "book" && vote.work_id == work
            @book_votes[work_id] += 1
        end
        if work.category == "movie" && vote.work_id == work
            @movie_votes[work_id] += 1
        end
        if work.category == "album" && vote.work_id == work
            @album_votes[work_id] += 1
        end
      end
    end
    
  end


  def index
    # @work = Work.find_by(id: params[:id])
    # @book_work = @work.where(category: "book").order(:title)
    # @movie_work = @work.where(category: "movie").order(:title)
    # @album_work = @work.where(category: "album").order(:title)

    #if work_id on params is truthy
    # if params[:work_id]
      @book_work = Work.where(category: "book").order(:title)
      @movie_work = Work.where(category: "movie").order(:title)
      @album_work = Work.where(category: "album").order(:title)
      if @book_work.empty? || @movie_work.empty? || @album_work.empty?
        render :not_found
      end
    # end
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
