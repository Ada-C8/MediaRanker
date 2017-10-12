class MainController < ApplicationController
  def index
    # MOVE TO MODEL!
    # @albums = Work.popular_works("albums")
    # @movies = Work.popular_works("movies")
    # @books = Work.popular_works("books")
    @top =  Work.top
    # @votes = Vote.where(work_id: params[:id])

    @movies = Work.where(category: "movie").sort_by{ |work| -work.votes.count}[0..9]
    @books = Work.where(category: "book").sort_by{ |work| -work.votes.count}[0..9]
    @albums = Work.where(category: "album").sort_by{ |work| -work.votes.count}[0..9]
  end
end
