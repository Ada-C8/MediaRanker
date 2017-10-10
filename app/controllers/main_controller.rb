class MainController < ApplicationController
  def index
    @works = Work.all
  end

end
