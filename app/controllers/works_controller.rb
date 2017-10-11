class WorksController < ApplicationController
  def index
    books = Work.where(category: "book")
    movies = Work.where(category: "movie")
    albums = Work.where(category: "album")

    @works = {Albums: albums, Books: books, Movies: movies}
  end

  def new
  end

  def show
    @work = Work.find_by(id: params[:id])
  end

  def create
  end

  def update
  end

  def edit
    @work = Work.find_by(id: params[:id])

    #TODO: decide on redirect if doesn't exist
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
end
