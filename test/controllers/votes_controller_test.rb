require "test_helper"

describe VotesController do
  it "a user should be able to vote on a work they have not yet voted on" do
    proc {post login_path, params: {user: {name: "HELLO IM NEW"}}}.must_change 'User.count', 1
    session[:logged_in_user]['name'].must_equal "HELLO IM NEW"

    post votes_path(works(:scandal))
    must_respond_with :redirect
    must_redirect_to work_path(works(:scandal))
    # this test is failing and I don't know why because the votes save in my browser
  end

  it "a user cannot vote on something they've already voted on" do
    proc {post login_path, params: {user: {name: users(:west).name}}}.must_change 'User.count', 0
    session[:logged_in_user].must_equal users(:west)

    proc {post votes_path(works(:greys))}.must_change 'Vote.count', 0
    must_respond_with :redirect
    must_redirect_to works_path
  end

  it "should not let someone vote who is not logged in" do
    proc {post vote_path(works(:greys))}.must_change 'Vote.count', 0
    must_redirect_to works_path
  end

end
