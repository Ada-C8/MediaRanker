require "test_helper"

describe SessionsController do
  it "should get login page" do
    get login_path
    must_respond_with :success
  end

  it "recognizes existing user" do
    user = users(:tanja)
    post login_path(name:user.name)
    must_respond_with :redirect
    must_redirect_to root_path
  end

  it "recognizes new user" do
    post login_path(name:"gogol bordello")
    must_respond_with :redirect
    must_redirect_to root_path
  end

  it "should render login form for invalid name" do
    post login_path(name:"")
    must_respond_with :success
  end

  it "invalid user login doesn't change user count" do
    proc {
      post login_path("")
    }.must_change 'User.count', 0
  end

  it "should allow user to logout" do
    delete logout_path
    must_respond_with :found
    must_respond_with :redirect
    must_redirect_to root_path
  end
end
