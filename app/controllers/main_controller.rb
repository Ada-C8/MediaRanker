class MainController < ApplicationController

  def index
    @top_work = Work.top_work
  end

end
