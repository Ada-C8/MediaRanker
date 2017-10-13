class MainController < ApplicationController
  def index
    @albums = Work.popular_works("album")
    @movies = Work.popular_works("movie")
    @books = Work.popular_works("book")
    @top =  Work.top
    # @votes = Vote.where(work_id: params[:id])

    # @movies = Work.where(category: "movie").sort_by{ |work| -work.votes.count}[0..9]
  end
end
