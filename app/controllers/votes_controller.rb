class VotesController < ApplicationController
  # before_action :find_vote

  def new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
    @votes = Vote.order(:created_at)
    @vote = Vote.find_by_id(:id)
    @work = Work.find_by_id(@vote)
  end

  def show
  end

  private

  def find_vote
    #find_by_id returns nil if there is nothing returned
    @vote = Vote.find_by_id(params[:id])
  end

end
