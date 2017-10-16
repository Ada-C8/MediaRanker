class VotesController < ApplicationController
  def index
  end

  def new
  end

  def show
  end

  def create
    @user = User.find_by(id: session[:user_id])
    @work = Work.find_by(id: params[:work])
    @vote = Vote.new
    @vote.user = @user
    @vote.work = @work
    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
