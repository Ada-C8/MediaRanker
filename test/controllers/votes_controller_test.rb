require "test_helper"

describe VotesController do
  it "should create a vote for correct user and work" do
    post login_path, params: { name: users(:two).name }
    get work_path(works(:album))
    proc {
      post votes_path
    }.must_change "Vote.count", 1

    users(:two).votes.size.must_equal 1
    works(:album).votes.size.must_equal 1
  end

  it "should not allow a vote unless the user is logged in" do
    proc {
      post votes_path(works(:book).id)
    }.must_change "Vote.count", 0
    flash[:error].must_equal "You must be logged in to vote"
  end
end
