class VotesController < ApplicationController
  def create
    @vote = Vote.new(user_id: session[:logged_in_user], work_id: params[:work_id])

    if @vote.save
      flash[:status] = :success
      flash[:message] = "Successfully upvoted!"

      redirect_back(fallback_location: root_path)
    else
      flash[:status] = :failure
      if @vote.errors.messages.include?(:user_id)
        flash[:message] = "You must log in to do that"
      else @vote.errors.messages.include?(:user)
        flash[:message] = "Could not upvote"
        flash[:details] = @vote.errors.messages
      end
      redirect_back(fallback_location: root_path)
      # can't figure out how to render the current page and send a bad_request message, so I'm just redirecting. I'm assuming that's why the test site has the weird "You are being redirected" page. I don't like that, so I'm just not.
    end
  end
end
