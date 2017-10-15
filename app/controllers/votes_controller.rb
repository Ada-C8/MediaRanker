class VotesController < ApplicationController


  def create
    if session[:logged_in_user]
      current_user = User.find(session[:logged_in_user])
    else
      flash[:status] = "failure"
      flash[:message] = "You must log in to upvote a work"
      redirect_to work_path(params[:id])
      return
    end

    if Vote.find_by(user_id: current_user.id, work_id: params[:id])
      flash[:status]= :failure
      flash[:message] = "You can only upvote a work you've not voted for"
      redirect_to works_path(params[:id])
      return

    else
      user_id = current_user.id
      work_id = params[:id]
      user_id = session[:logged_in_user]
      vote = Vote.new(work_id: work_id, user_id: user_id)
      vote.save!

      if vote.save
        redirect_back(fallback_location: root_path)
        flash[:status] = :success
        flash[:message] = "Successfully upvoted!"
      else
        redirect_back(fallback_location: root_path)
        # must find a way to status :bad_request or put a message on the
      end
    end
  end


  private
    def user_params
      return params.require(:vote).permit(:user_id, :work_id)
    end

end
