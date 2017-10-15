require "test_helper"

describe SessionsController do
  it "allows a user to login" do
    @user = users(:test_user)
    post login_path
    must_respond_with :redirect
    must_redirect_to root_path
  end

  it "allows a new user to create a user and login" do
    @user = User.new(username: "uniquetestingname")
    @user.save
    post login_path
    must_respond_with :redirect
    must_redirect_to root_path
  end

  it "allows a user to logout" do
    @user = users(:test_user)
    delete logout_path
    must_respond_with :redirect
    must_redirect_to root_path
  end
end
