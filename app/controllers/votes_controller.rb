class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    @current_user = User.find_by(id: session[:user_id])
    @work = Work.find_by(id: params[:work_id].to_i)

    if @current_user == nil || @work ==nil
      flash[:error] = "Could not vote"
      return redirect_to root_path
    end

    @current_user.vote(@work)
    redirect_to work_path(@work.id)
  end

  # def index
  # end

  # def show
  # end

  # def update
  # end

  # def destroy
  # end

  # def edit
  # end

  private

  def vote_params
    # not sure if i need this
    return params.require(:vote).permit(:work_id, :user_id)
  end

end
