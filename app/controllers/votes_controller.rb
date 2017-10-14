class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    user_id = User.find_by(id: params[:user][:id]).id
    work_id = Work.find_by(id: params[:work][:id].id
    @vote = Vote.new(user_id: user_id, work_id: work_id)
      if @vote.save
        redirect_to work_path
        return
      else
        redirect_to work_path, status: :bad_request
        return
      end


  end
end
