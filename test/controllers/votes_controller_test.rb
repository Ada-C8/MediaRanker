require "test_helper"

describe VotesController do
  it "a user should be able to vote on a work they have not yet voted on" do
    proc {post login_path, params: {user: {name: users(:west).name}}}.must_change 'User.count', 0
    session[:logged_in_user].must_equal users(:west)

    proc { post votes_path(works(:scandal))}.must_change 'Vote.count', 1
    must_respond_with :redirect

  end

  # it "should not let someone vote who is not logged in" do
  #   session[:logged_in_user] = nil
  #   # proc {post votes_ptes, params: {vote: {works(:greys)}}}
  # end

end
