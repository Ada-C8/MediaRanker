class WorksController < ApplicationController
  def index
    @works = Work.all
  end # index

  def show
  find_work_by_params
  end # show

  private
  def find_work_by_params
    @work = Work.find_by(id: params[:id])
    # unless @book
    #   head :not_found
    # end
  end

end
