class HomeController < ApplicationController
  def index
    @top_movies = Work.where(category: 'movie').limit(10)
    @top_books = Work.where(category: 'book').limit(10)
    @top_albums = Work.where(category: 'album').limit(10)
    @spotlight = Work.first
  end

end


#this will be modified to contain 10 highest rated works.
