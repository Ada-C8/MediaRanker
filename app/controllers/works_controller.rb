class WorksController < ApplicationController
  def create
  end

  def destroy
  end

  def edit
  end

  def new
  end

  def show
  end

  def update
  end

  def index
    @works = Work.order(:category)
  end
end
