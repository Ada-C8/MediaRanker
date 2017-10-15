class VotesController < ApplicationController
  def new
    @vote = Vote.new
    # if params[:user_id]
      @vote.user_id = session[:logged_in_user]
      @vote.work_id = params[:work_id]
      @vote.save
      redirect_to works_path
    # end
  end

  # def create
  #   @vote = Vote.new(vote_params)
  #   @vote.save
  #   redirect_to works_path
  # end
  # def create
  #   @vote = Vote.new(vote_params)
  #   @vote.work = Work.find(params[:work_id])
  #   @vote.save
  # end


  private

  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end


end

#
# def create
#   @vote = Vote.new
#   @vote.user_id = session[:logged_in_user]
#   @vote.work_id = @work.id
#   @vote.save
#   redirect_to works_path
# end
