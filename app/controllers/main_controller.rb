class MainController < ApplicationController

  def index
    @top_work = Work.top_work
    @albums_sorted_by_votes = Work.albums_sorted_by_votes
    @books_sorted_by_votes = Work.books_sorted_by_votes
    @movies_sorted_by_votes = Work.movies_sorted_by_votes
  end

end
