require "test_helper"

describe VotesController do
  it "Should be able to CREATE a new vote" do
    proc  {
      post votes_path, params: {votes: {user: :one, work: :one}} }.must_change 'votes.count', 1

      must_respond_with :redirect
      must_redirect_to work_path(@work.id)
  end

end
