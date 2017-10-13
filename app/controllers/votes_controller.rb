class VotesController < ApplicationController
  def create
    @user = User.find_by(id: session[:user_id])
    @work = Work.find_by(id: params[:work])

    if session[:user_id]
      @vote = Vote.new
      @vote.user = @user
      @vote.work = @work
      if @vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:error] = "You must log in to do that"
    end
  end
end
