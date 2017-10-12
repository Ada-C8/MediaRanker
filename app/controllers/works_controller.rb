class WorksController < ApplicationController
  def index
    @works = Work.all
  end # index
end
