require "test_helper"

describe VotesController do
  it "should be able to create a new vote" do
    greys = works(:greys).id
    # post login_path, params: {user: {name: users(:west).name}}
    post votes_path, params: {vote: {works: greys, user: session[:logged_in_user]['id']}}
    # must_respond_with :failure
    # must_redirect_to :new
  end

  it "should not let someone vote who is not logged in" do

  end

end
