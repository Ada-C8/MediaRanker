class VotesController < ApplicationController
  def new
    #@vote = Vote.new
    # if params[:user_id]

  end

  def create
    # user_id = session[:logged_in_user]

    @vote = Vote.new(vote_params)

    # @vote.user_id = session[:logged_in_user]
    # @vote.work_id = params[:work_id]
    @vote.save
    redirect_to works_path
  end

  # @user = User.new(user_params)
  # @user.save
  # session[:logged_in_user] = @user.id
  # redirect_to works_path

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
