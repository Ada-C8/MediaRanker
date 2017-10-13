class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new vote_params
    puts @vote.as_json
    if @vote.save
      puts "saved"
      redirect_to work_path(@vote.work_id)
    else
      puts "not saved"
      puts @vote.errors.to_s
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
    return params.require(:vote).permit(:work_id, :user_id)
  end

end
