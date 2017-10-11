class WorksController < ApplicationController
  def index
    @works = Work.get_works
    print @works
  end

  def show
    @work = Work.find_by(id: params[:id].to_i)
    unless @work
      redirect_to works_path
    end
  end
end
