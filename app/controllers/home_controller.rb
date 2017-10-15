class HomeController < ApplicationController
  def index
    @top_movies = Work.movies.limit(10)
    @top_books = Work.books.limit(10)
    @top_albums = Work.albums.limit(10)
    @spotlight = Work.spotlight
  end

end


#this will be modified to contain 10 highest rated works.
