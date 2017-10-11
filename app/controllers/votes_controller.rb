class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def create
    @user = User.find(1)
    @vote = Vote.new(user_id: @user.id, work_id: params[:work_id])

    if @vote.save
      redirect_to work_path(params[:work_id])
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
