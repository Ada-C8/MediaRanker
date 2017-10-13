require "test_helper"

describe VotesController do
  it "should display a list of all votes" do
    get votes_path
    must_respond_with :success
  end

  it "should show a specific vote's details on the show page" do
    get vote_path(votes(:one))
    must_respond_with :success
  end

  it "should produce a form for creating a new vote" do
    get new_vote_path
    must_respond_with :success
  end

  it "should be able to create a new vote" do
    post votes_path params: {vote: {work: works(:greys), user: users(:west)}}
    must_respond_with :redirect
    must_redirect_to votes_path
  end

  it "should be able to destroy a vote" do
    delete vote_path(votes(:one))
    must_respond_with :redirect
    # must_redirect_to
  end

end
