class MainPageController < ApplicationController
  def index
    #TODO fix this sorting!
    works = Upvote.group(:work_id).count
    top = works.max_by { |id,count| count }
    @top = Work.find(top[0])
    books = Work.where(category: "book")
    book_results = books.sort_by { |work| -1*work.upvotes.count }
    @top_books = book_results[1..10]
    movies = Work.where(category: "movie")
    movie_results = movies.sort_by { |work| -1*work.upvotes.count }
    @top_movies = movie_results
    albums = Work.where(category: "album")
    album_results = albums.sort_by { |work| -1*work.upvotes.count }
    @top_albums = album_results
  end
end
