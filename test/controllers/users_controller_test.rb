require "test_helper"

describe UsersController do
  let(:one) { users(:one) }
  let(:two) { users(:two) }

  it "should get index" do
    get users_path
    must_respond_with :success
  end

  it "should get show path with a valid work id" do
    # successful with valid id
    get user_path(one.id)
    must_respond_with :success, "Did not get the show page for a valid id"
    # redirects with invalid id
    get work_path(-1)
    must_respond_with :not_found, "Incorrectly got the show page for invalid id"
  end

  describe "logging in" do
    it "should get the login form" do
      get login_form_path
      must_respond_with :success, "Got the login_form page"
    end

    it "should simply log in a user if their username exists and there is no user data in session" do
      post login_path, params: {username: one.username}
      must_respond_with :redirect
      must_redirect_to root_path
      session[:user_id].must_equal one.id
      flash[:success].must_equal "Successfully logged in as existing user userone"
    end

    it "should not allow a user to log in when they are already logged in" do
      post login_path, params: {username: one.username}
      session[:user_id].must_equal one.id
      flash[:success].must_equal "Successfully logged in as existing user userone"
      post login_path, params: {username: two.username}
      must_respond_with :redirect
      must_redirect_to root_path
      flash[:error].must_equal "You are already logged in as #{one.username}"
      session[:user_id].must_equal one.id
    end

    it "should create a new user when the username does not exist" do
      proc{
        post login_path, params: {username: "newuser"}
      }.must_change 'User.count', +1
      must_respond_with :redirect
      must_redirect_to root_path
      newuser = User.find_by(username: "newuser")
      flash[:success].must_equal "Successfully created new user newuser with ID #{newuser.id}"
      session[:user_id].must_equal newuser.id
    end
  end
end
