require "test_helper"

describe VotesController do
  it "should create a vote" do
    proc {
      post votes_path, params: { vote: {user_id: 2, work_id: 9 }}
    }.must_change 'Vote.count', 1

    must_respond_with :success
  end
end
