require "test_helper"

describe VotesController do

  it "Should be able to CREATE a new vote" do
    proc  {
      post votes_path, params: {vote: {user_id: users(:two).id, work_id: works(:two).id}} }.must_change 'Vote.count', 1

      # must_respond_with :redirect
      # must_redirect_to work_path(@work.id)
  end

end
