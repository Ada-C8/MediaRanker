class VotesController < ApplicationController
  def upvote
    puts "Session user_id is #{session[:logged_in_user]}"

    unless User.find_by(id: session[:logged_in_user])
      flash[:status] = :failure
      flash[:message] = "You must log in to do that"
      redirect_to "/login"
      return
    end

    if Vote.find_by(user_id: session[:logged_in_user], work_id: params[:id])
      flash[:status] = :failure
      flash[:message] = "You have already voted for that work"
      redirect_to work_path
    else
      vote = Vote.new
      vote.user_id = session[:logged_in_user]
      vote.work_id = params[:id]
      vote.save
      flash[:status] = :success
      flash[:message] = "You have successfully voted for this work"
      redirect_to works_path
    end
  end
end
