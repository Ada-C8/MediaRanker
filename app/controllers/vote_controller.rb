class VoteController < ApplicationController

  def new
    @vote = Vote.new
    if params[:media_instance_id, :user_id]
      @vote.media_instance_id = params[:media_instance_id]
      @vote.user_id = params[:user_id]
    else
      render media_instances_path
    end
  end

  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      redirect_to media_instance_path(@vote.media_instance_id)
    else
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
    redirect_to media_instance_path(@vote.media_instance_id)
  end

private

def trip_params
  return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
end # trip_params

end
