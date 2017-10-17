require "test_helper"

describe VotesController do
  it "should create a vote" do
    proc {
      post votes_path, params: { vote: {user_id: 2, work_id: 9 }}
    }.must_change 'Vote.count', 1

    must_respond_with :redirect
    must_redirect_to works_path
  end

  # it "should not create a vote if the user is not logged in" do
  #   proc {
  #     post votes_path, params: { vote: {user_id: nil, work_id: 6 }}
  #   }.must_change 'Vote.count', 0
  #
  #   must_respond_with :error
  #   must_redirect_to works_path
  # end
end
