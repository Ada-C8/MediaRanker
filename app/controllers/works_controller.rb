class WorksController < ApplicationController
  def index
    @works = Work.order(:id)
  end

  def show
  end

  def new
  end

  def edit
  end

  def update
  end

  def create
  end

  def destroy
  end
end
