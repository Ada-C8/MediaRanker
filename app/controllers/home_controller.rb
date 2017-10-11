class HomeController < ApplicationController

  def index
    @works = Work.all#.sort(vote).limit(10)
  end
end
