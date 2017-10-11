class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find(params[:id].to_i)
  end

  def create
  end

  def new
  end

  def destroy
  end

  def edit
  end

  def update
  end
end
