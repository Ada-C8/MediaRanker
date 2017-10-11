class MainController < ApplicationController
  def index
    @movies = Work.where(category: "movie").limit(10).sort_by{ |work| -work.votes.count}
    @books = Work.where(category: "book").limit(10).sort_by{ |work| -work.votes.count}
    @albums = Work.where(category: "album").limit(10).sort_by{ |work| -work.votes.count}
  end
end
