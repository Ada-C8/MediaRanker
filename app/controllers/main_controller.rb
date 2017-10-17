class MainController < ApplicationController
  def index
    works = Work.all
    @works = works.sort_by {|work| -work.votes.count}
    movies = Work.where(category: "movie")[0..9]
    @movies = movies.sort_by {|work| -work.votes.count}
    books = Work.where(category: "book")[0..9]
    @books = books.sort_by {|work| -work.votes.count}
    albums = Work.where(category: "album")[0..9]
    @albums = albums.sort_by {|work| -work.votes.count}
  end

end
