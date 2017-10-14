class VotesController < ApplicationController

  # def new
  #   @vote = Vote.new
  #   if params[:media_instance_id, :user_id]
  #     @vote.media_instance_id = params[:media_instance_id]
  #     @vote.user_id = params[:user_id]
  #   else
  #     render media_instances_path
  #   end
  # end

  def create
    #binding.pry
    #stubbed_params = {user_id: 1, media_instance_id: 1}
    @vote = Vote.new(vote_params)
    if @vote.save
      flash[:status] = :success
      flash[:message] = "Successfully created vote #{@vote.id}"
      redirect_to media_instances_path(@vote.media_instance_id)
    else
      # Tell the user what went wrong
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create vote"
      flash.now[:details] = @vote.errors.messages
      render :new, status: :bad_request
    end
  end

  def destroy
    current_user = nil
    if session[:logged_in_user]
      current_user = user.find_by(id:session[:logged_in_user])
    end
    # @vote = Vote.find(params[:id])
    if find_vote_by_params_id
      if current_user != @vote.user
        flash[:status] = :failure
        flash[:message] = "Only the voter can destroy the vote!"
        redirect_to media_instances_path
        return
      end

      @vote.destroy
      flash[:status] = :success
      flash[:message] = "Deleted vote #{@vote.id}"
      redirect_to votes_path
    end
    redirect_to media_instance_path(@vote.media_instance_id)

  end
  private

  def vote_params
    params.permit(:user_id, :media_instance_id)
  end

end
