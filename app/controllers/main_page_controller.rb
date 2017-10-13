class MainPageController < ApplicationController
  def index
    works = Upvote.group(:work_id).count
    top = works.max_by { |id,count| count }
    @top = Work.find(top[0])

    books = Work.where(category: "book")
    book_results = books.sort_by { |work| -1*work.upvotes.count }
    @top_books = book_results[0..[9, book_results.length].min]

    movies = Work.where(category: "movie")
    movie_results = movies.sort_by { |work| -1*work.upvotes.count }
    @top_movies = movie_results[0..[9,
    movie_results.length].min]

    albums = Work.where(category: "album")
    album_results = albums.sort_by { |work| -1*work.upvotes.count }
    @top_albums = album_results[0..[9,album_results.length].min]
  end
end
