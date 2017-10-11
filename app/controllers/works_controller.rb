class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @works = Work.find_by(id: params[:id].to_i)
  end

  def edit
  end

  def update
  end

  def new
  end

  def create
  end

  def destroy
  end
end
