require "test_helper"

describe SessionsController do
  it "should get the login form" do
    get login_path
    must_respond_with :success
  end

  describe "Logging in" do
    it "starts session for existing user if logging in as existing user" do
      user_one = users(:user_one)
      post login_path, params: { username: user_one.username}

      session[:user_id].must_equal user_one.id
    end
  end

  it "creates a new user if logging in with a new username" do
    new_username = "buoy"

    proc {
      post login_path, params: { username: new_username}
    }.must_change 'User.count', 1

    new_user = User.find_by(username: new_username)
    session[:user_id].must_equal new_user.id
  end

  it "raises an error if you try to login without a username (blank/empty username field)" do
    proc {
      post login_path, params: { username: ""}
    }.must_change 'User.count', 0
  end
end
