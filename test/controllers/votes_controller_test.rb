require "test_helper"

describe VotesController do
  it "should create a vote for correct user and work" do
    post login_path, params: { name: users(:two).name }
    proc {
      post work_votes(works(:album))
    }.must_change "Vote.count", 1

    users(:two).votes.size.must_equal 1
    works(:album).votes.size.must_equal 1
  end

  it "should not allow a vote unless the user is logged in" do
    post login_path
    must_respond_with :failure
    Vote.count.must_equal 0
  end
end
