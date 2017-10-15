class VotesController < ApplicationController
  # before_action :find_vote

  def new
  end

  def create
    @vote = Vote.new
    @vote.user_id = session[:name]
    @vote.work_id = params[:id]
    if @vote.save
      flash[:success] = "Vote added successfully"
      redirect_to work_path(params[:id])
    else
      flash.now[:error] = "Vote not recorded successfully"
      redirect_to works_path, alert: "You're stuck here!"
    end
  end

  def index
    @votes = Vote.order(:created_at)
    @vote = Vote.find_by_id(:id)
    @work = Work.find_by_id(vote.work_id)
  end

  private

  def find_vote
    #find_by_id returns nil if there is nothing returned
    @vote = Vote.find_by_id(params[:id])
  end

end
