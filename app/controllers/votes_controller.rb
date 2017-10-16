class VotesController < ApplicationController
  def create
    @user = User.find_by(id: session[:user_id])
    @work = Work.find_by(id: params[:work])

    if @user_in_session
      @vote = Vote.new
      @vote.user = @user
      @vote.work = @work
      if @vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: root_path)
      else
        flash[:failure] = "Could not upvote"

        if @vote.errors.any?
          flash[:errors] = @vote.errors
        end

        redirect_back(fallback_location: root_path)
      end
    else
      flash[:failure] = "You must log in to do that"
      redirect_back(fallback_location: root_path)
    end
  end
end
