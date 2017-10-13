class VotesController < ApplicationController

  def index
    @votes = Vote.all
  end

  def show
    @vote = Vote.find(params[:id])
  end

  def new
    @vote = Vote.new
  end

  def edit
    @vote = Vote.find(params[:id])
  end

  def create
    @vote = Vote.new
    @vote.save
  end

  def update
    @vote = Vote.find(params[:id])
    @vote.update_attributes
    @vote.save
  end

  def destroy
    vote = Vote.find(params[:id])
    vote.destroy
    redirect to votes_path
  end

end
