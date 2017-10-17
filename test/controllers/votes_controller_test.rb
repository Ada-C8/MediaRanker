require "test_helper"

describe VotesController do

  before do
    post login_path, params: {username: "rainbow"}
    flash[:success].must_equal "rainbow is successfully logged in"
  end

  it "can create a vote" do
    Vote.first.destroy
    proc { post create_vote_path(Work.first.id) }.must_change 'Vote.count', 1
    flash[:success].must_equal "Successfully upvoted!"
  end

  it "prevents multiple voting from the same user" do
    proc { post create_vote_path(Work.first.id) }.must_change 'Vote.count', 0
    flash[:error].must_equal "Hey! You've already voted for that!"
  end

  it "requires the user to be logged in to vote" do
    delete logout_path
    post create_vote_path(Work.first.id)
    flash[:error].must_equal "You must be logged in to do that!"
  end
end
