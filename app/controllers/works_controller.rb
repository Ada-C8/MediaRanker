class WorksController < ApplicationController
  #add a control action with login name and status

  def home
    #ALTERNATE CODE - DOESN"T WORK YET BUT ALMOST THERE- THIS LINE AND PRIVATE METHOD MAY REALLY DRY UP CODE
    # @top_books = media_votes("book").sort_by{|key, value| -value }[0..9]
    # @top_movies = media_votes("movie").sort_by{|key, value| -value }[0..9]
    # @top_albums = media_votes("album").sort_by{|key, value| -value }[0..9]
    # @spotlight = spotlight_media

    @votes = Vote.all
    @works = Work.all

    #Create Hashes for each media with 0 as default value:
    @book_votes = Hash.new
    @movie_votes = Hash.new
    @album_votes = Hash.new

    @works.each do |work|
      if work.category == "book"
        @book_votes[work] = 0
      elsif work.category == "movie"
        @movie_votes[work] = 0
      elsif work.category == "album"
          @album_votes[work] = 0
      end
    end

    # Am I making my life too hard? Is this an easier way?
    # Deal.find(:all, :order => 'quantity_purchased * price', :limit => 100)

    #Iterate through votes collection to determine counts for each media
    @votes.each do |vote|
      @book_votes.each do |book, book_vote|
        if vote.work_id == book.id
            @book_votes[book] += 1
        end
      end
    end

    @votes.each do |vote|
      @movie_votes.each do |movie, movie_vote|
        if vote.work_id == movie.id
            @movie_votes[movie] += 1
        end
      end
    end

    @votes.each do |vote|
      @album_votes.each do |album, album_vote|
        if vote.work_id == album.id
            @album_votes[album] += 1
        end
      end
    end

    #variable holds top ten media. Sorts hashes from highest to lowest values and returns first 10 pair values in the hash.
    @top_books = @book_votes.sort_by{|key, value| -value }[0..9]
    @top_movies = @movie_votes.sort_by{|key, value| -value }[0..9]
    @top_albums = @album_votes.sort_by{|key, value| -value }[0..9]


  end


  def index
    @work = Work.all

    #if work_id on params is truthy
    # if params[:work_id]
      @book_work = Work.where(category: "book").order(:title)
      @movie_work = Work.where(category: "movie").order(:title)
      @album_work = Work.where(category: "album").order(:title)
      # if @book_work.empty? || @movie_work.empty? || @album_work.empty?
      #   render :not_found
      # end
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
      flash[:success] = "Work added successfully"
      redirect_to works_path
    else
      flash.now[:error] = "Work not added successfully"
      render :new
    end
  end

  def destroy
  end


private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :pub_year, :description)
  end

end
