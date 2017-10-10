class WorksController < ApplicationController
  def create
  end

  def destroy
  end

  def edit
  end

  def index
  end

  def new
  end

  def show
    @work = Work.find( params[:id].to_i)
  end

  def update
  end
end
