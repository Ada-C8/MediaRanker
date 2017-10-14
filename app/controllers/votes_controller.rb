class VotesController < ApplicationController


  def create
    # user_id = 1
    # task = Task.new(task: params[:task][:task] , description: params[:task][:description], due_date: params[:task][:due_date], status: false )
    work_id = params[:id]
    user_id = 1
    vote = Vote.new(work_id: work_id, user_id: user_id)
    vote.save!
    if vote.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
      # must find a way to status :bad_request or put a message on the 
    end
  end


  private
    def user_params
      return params.require(:vote).permit(:user_id, :work_id)
    end

end
