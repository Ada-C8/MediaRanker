class VotesController < ApplicationController

 def create
   @user = User.find_by(id: session[:user_id])

   if @user == nil
     flash[:error] = "You must be logged in to vote!"
   elsif Work.already_voted?(params[:work_id], @user.id)
     flash[:error] = "Sorry, you already voted for that one."
   else
     @vote = Vote.new(user_id: @user.id, work_id: params[:work_id])
     if !@vote.save
       flash[:error] = "Sorry, that vote didn't go through."
     end
   end
   redirect_to work_path(params[:work_id])
 end

end
