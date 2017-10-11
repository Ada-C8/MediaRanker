class HomeController < ApplicationController
  def index
    @albums = Work.all.where(category: "album").limit(10).sort_by{|work| -work.votes.count}
    @books = Work.all.where(category: "book").limit(10).sort_by{|work| -work.votes.count}
    @movies = Work.all.where(category: "movie").limit(10).sort_by{|work| -work.votes.count}
  end
end
