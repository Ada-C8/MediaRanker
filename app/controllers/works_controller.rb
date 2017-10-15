class WorksController < ApplicationController
  before_action :get_work , only: [:show, :edit, :update, :destroy]

  def get_work
    @work = Work.find(params[:id])
  end

  def index
    @works = Work.all.order(:category, :title)
  end

  def show
    # @work = Work.find(params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:status] = :success
      flash[:message] = "Successfully created work #{@work.id}"
      redirect_to works_path
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create new work"
      render :new, status: :bad_request
    end
  end

  # @book = Book.new(book_params)

  # if @book.save
  #   flash[:status] = :success
  #   flash[:message] = "Successfully created book #{@book.id}"
  #   redirect_to books_path
  # else
    # Tell the user what went wrong
    # flash.now[:status] = :failure
    # flash.now[:message] = "Failed to create book"
    # flash.now[:details] = @work.errors.messages
    # render :new, status: :bad_request
  # end
# end




  def edit
    # @work = Work.find(params[:id])
  end

  def update
    # @work = Work.find(params[:id])
    @work.update_attributes(work_params)
    @work.save
    redirect_to works_path
  end

  def destroy
    # @work = Work.find(params[:id])
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
