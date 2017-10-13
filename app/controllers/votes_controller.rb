class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new #vote_params

    if @vote.save
      redirect_to work_path.id
      work_path(@work.id)
    else
      # work_path(@work.id)
    end
  end

  # def index
  # end
  #
  # def show
  # end
  #
  # def update
  # end
  #
  # def destroy
  # end
  #
  # def edit
  # end


  private

  def vote_params
    # not sure if i need this
    # return params.require(:vote).permit(:vote)
  end

end
