class VotesController < ApplicationController

  def create
    user_id = session[:logged_in_user]
    work_id = params[:id]
    @vote = Vote.new(user_id: user_id, work_id: work_id)

    if @vote.save
      flash[:status] = :success
      flash[:message] = "Successfully upvoted!"
      redirect_back(fallback_location: root_path)
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Could not upvote. User: has already voted for this work"
      redirect_back(fallback_location: root_path)
    end
  end


  # def upvote
  #   @work = Work.find(params[:id])
  #   user.id = session[:logged_in_user]
  #   @work.votes.new(user_id: user.id)
  #
  #   if @work.save
  #     flash[:status] = :success
  #     flash[:message] = "Successfully upvoted!"
  #     redirect_to work_path
  #   else
  #     flash[:status] = :failure
  #     flash[:message] = "Could not upvote"
  #     redirect_to work_path
  #   end
  # end

  private
    def vote_params
      return params.require(:vote).permit(:user_id, :work_id)
    end
end
