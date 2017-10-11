class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def edit
  end

  def update
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work == nil
      redirect_to works_path
    end
  end

  def create
  end

  def new
  end

  def destroy
  end
end
