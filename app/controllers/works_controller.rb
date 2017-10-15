class WorksController < ApplicationController
  def index
    @works = Work.all.order(:category, :title)
  end

  def show
    @work = Work.find(params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Saved!"
      redirect_to works_path
    else
      render :new
    end
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    @work.update_attributes(work_params)
    @work.save
    redirect_to works_path
  end

  def destroy
    @work = Work.find(params[:id])
    @work.destroy
    redirect_to works_path
  end

  def topten
  end

  # def upvote
  #   @work = Work.find(params[:id])
  #   @work.votes.create
  #   redirect_to new_vote_path
  #
  #   # render :topten
  #   #want to create a vote, which includes this id as the work id and the logged in user id as the user-id
  #   # @work.votes.create
  #   # redirect_to works_index_path
  #   # get 'works/:id/upvote', to: 'works#upvote', as: 'upvote_work'
  #   #
  #
  # end

#   def upvote
#   @startup = Startup.find(params[:id])
#   upvote = @startup.upvotes.find_or_create_by(user: current_user)
#   upvote.save
#   redirect_to startups_path
# end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
