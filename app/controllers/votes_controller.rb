class VotesController < ApplicationController

  before_action :require_login

  def create
  #def upvote
    # user = User.find_by(id: params[:id])
    # user = User.find_by(username: params[:username])
    user = User.find_by(id: session[:user_id])
    work = Work.find_by(id: params[:id])

    @vote = Vote.new
    @vote.user = user
    @vote.work = work

    if @vote.save
      flash[:success] = "Successfully upvoted!"
      #TODO: redirect to the same page you were on
      redirect_back(fallback_location: root_path)
    else

      if logged_in?
        flash[:failure] = "Could not upvote" #if already voted, then display error message
        @errors = @vote.errors
        # flash[:errors] = "#{@errors.first[1]}"
        redirect_back(fallback_location: root_path, notice: "#{@errors.first[1]}")
      else
        flash[:failure] = "You must log in to do that"
        redirect_back(fallback_location: root_path)
      end

    end

  end

end
