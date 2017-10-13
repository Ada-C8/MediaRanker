class MainController < ApplicationController
  def index
    @best = Work.best
    @best_movies = Work.best_10('movies')
    @best_books = Work.best_10('books')
    @best_albums = Work.best_10('albums')
  end
end
