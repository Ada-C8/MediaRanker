class HomeController < ApplicationController
  def index
    @works = Work.all
    @movies = Work.where(category: "movie").sort_by { |work| work.votes.length }
    @books = Work.where(category: "book").sort_by { |work| work.votes.length }
    @albums = Work.where(category: "album").sort_by { |work| work.votes.length }
  end
end
