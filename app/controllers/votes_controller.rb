class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def show
    @vote = Vote.find_by(id: params[:id])
  end

  def new
    @vote = vote.new
  end

  def create
    @vote = Vote.new
    if @vote.save
      redirect_to votes_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
end
