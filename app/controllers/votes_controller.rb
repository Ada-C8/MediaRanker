class VotesController < ApplicationController
  def create
    @vote = Vote.new vote_params

    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path(id: params[:id])
    else
      render :show
    end 

  end

  private

  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end
end
