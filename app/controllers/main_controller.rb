class MainController < ApplicationController
  def index
    @spotlight = Work.spotlight
    unless @spotlight
      @new = "None"
    end
  end
end
