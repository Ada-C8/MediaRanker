class VotesController < ApplicationController
  def create
    @user = User.find_by(id: session[:user_id])
    @work = Work.find_by(id: params[:work])

    # if @user.include_work?(work)
    #   flash[:error] = "Unable to "
    #   render #back to where you came from
    # else
      @vote = Vote.new
      @vote.user = @user
      @vote.work = @work
      if @vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: root_path)
      end
    # end
  end
end
