class WorksController < ApplicationController
  def home
    @works = Work.order(:id)
  end

  def index
    @works = Work.order(:id)
  end

  def edit
    @work = Work.find_by(id: params[:id])
    unless @work
      redirect_to work_path(@work.id)
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    redirect_to work_path(@work.id) unless @work

    if @work.update_attributes work_params
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work == nil
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work.id)
    else
      render :new
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id]).destroy
    redirect_to root_path
  end

  def upvote
    if !session[:user_id]
      flash[:error] = "You must log in to do that"
      redirect_back(fallback_location: :root)
    else
      @vote = Vote.new
      @vote.user_id = session[:user_id]
      @vote.work_id = params[:id]
      if !@vote.save
        flash[:status] = :error
        flash[:message] = "Could not upvote. User has already voted for this work."
        redirect_back(fallback_location: :root)
      else
        flash[:status] = :success
        flash[:message] = "Successfully upvoted!"
        redirect_back(fallback_location: :root)
      end
    end
  # end
  #   user = User.find_by(id: session[:user_id])
  #   work = Work.find_by(id: params[:work_id])
  #   if session[:user_id] != nil
  #     if work.voted?(user) == true
  #       flash[:status] = :error
  #       flash[:message] = "user has already voted for this work"
  #       redirect_back(fallback_location: root_path)
  #     else
  #       @vote = Vote.create!(user_id: user.id, work_id: work.id)
  #       flash[:status] = :success
  #       flash[:message] = "Successfully upvoted!"
  #       redirect_back(fallback_location: root_path)
  #     end
  #   else
  #     flash[:status] = :error
  #     flash[:message] = "You must log in to do that"
  #     redirect_back(fallback_location: root_path)
  #   end
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def voted?
    if Vote.where(user_id: user.id, work_id: work.id).count != 0
      return true
    else
      return false
    end
  end


end
