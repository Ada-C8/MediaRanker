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
    # user_id = 1
    # task = Task.new(task: params[:task][:task] , description: params[:task][:description], due_date: params[:task][:due_date], status: false )
    work_id = params[:id]
    puts "WORK ID"
    puts "*****" * 10
    puts work_id
    puts "*****" * 10
    user_id = 1
    vote = Vote.new(work_id: work_id, user_id: user_id)
    vote.save!
    if vote.save
      puts "SAVEDDDDDD"
      puts "*****" * 10
    end
    redirect_to work_path(params[:id])
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

  private
    def user_params
      return params.require(:vote).permit(:user_id, :work_id)
    end

end
