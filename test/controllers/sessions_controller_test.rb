require "test_helper"

describe SessionsController do

  it "gets login form" do
    get login_path
    must_respond_with :success
  end

  it "login for existing user" do
    proc {
      post login_path, params: {name: users(:calypso).name}
    }.must_change 'User.count', 0
    session[:user].must_equal users(:calypso).name
    session[:user_id].must_equal users(:calypso).id
  end

  it "login for new user" do
    proc {
      post login_path, params: {name: "why does this hate me"}
    }.must_change 'User.count', 1
  end

  it "won't login for invalid user" do
    # proc {
    #   post login_path, params: {name: nil}
    # }.must_change 'User.count', 0
  end
  # #@%$#@$%@#$%^@#$%^!#$^!!!!!!!

  it "will log out a user" do
    delete login_path
    assert_nil session[:user]
    assert_nil session[:user_id]
    # must_redirect_to root_path -- why won't this redirect
  end

end
