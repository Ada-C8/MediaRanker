class MainController < ApplicationController
  def index
    @best = Work.best
    @best_movies = Work.best_10('movie')
    @best_books = Work.best_10('book')
    @best_albums = Work.best_10('album')
  end
end
