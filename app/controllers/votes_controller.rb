class VotesController < ApplicationController

  def create
    @vote = Vote.new
    #get user id from session
    #get work id from params -so needs to be in route
    # vote nested in works
  end

end
