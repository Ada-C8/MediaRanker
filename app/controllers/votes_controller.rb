class VotesController < ApplicationController

  def create
    @vote = Vote.new(user_params)

    if @user.save
      flash[:success] = "Successfully created User #{@user.username}!"
      redirect_to user_path(@user.id)
    else
      flash.now[:error] = "A problem occurred: Could not create User #{@user.username}"
      render :new
    end
  end
end
