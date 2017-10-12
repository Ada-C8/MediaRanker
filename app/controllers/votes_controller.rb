 class VotesController < ApplicationController
  # def index
  #   @votes = Vote.all
  # end
  #
  # def new
  #
  # end

  def create
    @user = User.find(session[:user_id])

    if Work.already_voted?(params[:work_id], @user.id)
      flash[:error] = "Sorry, you already voted for that one."
      redirect_to work_path(params[:work_id])
    else
      @vote = Vote.new(user_id: @user.id, work_id: params[:work_id])
        if @vote.save
          redirect_to work_path(params[:work_id])
        else
          flash[:error] = "Sorry, that vote didn't go through."
        end
    end
  end

  # def edit
  # end
  #
  # def update
  # end
  #
  # def destroy
  # end

end
