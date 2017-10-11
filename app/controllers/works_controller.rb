class WorksController < ApplicationController
  def index
    @works = Work.get_works
    print @works
  end
end
