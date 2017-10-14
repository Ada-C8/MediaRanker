class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def new
    @works = Work.new
    if params[:creator]
      @works.creator = params[:creator]
    end
  end

  def create

  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end
end
