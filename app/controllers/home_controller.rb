class HomeController < ApplicationController

  def index
    @books = Work.where(category: "book").sort_by { |work| work.votes.length}.reverse
    @movies = Work.where(category: "movie").sort_by { |work| work.votes.length}.reverse
    @albums = Work.where(category: "album").sort_by { |work| work.votes.length}.reverse

    @spotlight = Vote.media_spotlight
  end
end
