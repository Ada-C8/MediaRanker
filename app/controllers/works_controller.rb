class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def create
  end

  def new
    @work = Work.new
  end

  def edit
  end

  def show
    @work = Work.find_by(id: params[:id])
    # @votes = @work.votes.order(:created_at)
  end

  def update
  end

  def destroy
  end

  def main
    @works= Work.all
  end
end
