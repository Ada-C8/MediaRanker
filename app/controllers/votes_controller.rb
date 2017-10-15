class VotesController < ApplicationController
  def new
    @vote = Vote.new(user_id: params[:user][:user_id])
  end

  def create
    @wvote = Vote.new(user_id: params[:user][:user_id])

    if @work.save
      flash[:status] = :success
      flash[:message] = "Successfully created work #{@work.id}"
      redirect_to works_path
    else
      # Tell user what went wrong
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create work"
      flash.now[:details] = @work.errors.messages
      render :new, status: :bad_request
    end
  end

end
