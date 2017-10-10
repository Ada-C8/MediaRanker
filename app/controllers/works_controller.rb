class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show
    @work = Work.find(work)
  end
end
