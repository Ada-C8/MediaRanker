require "test_helper"

describe UsersController do
  let(:one) { users(:one) }

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
      skip
      # session[:user_id] = nil
      # puts "-------------------"
      # puts one.username
      # puts "-------------------"
      # post login_path(one.username)
      # must_respond_with :redirect
      # must_redirect_to :root_path
      # flash[:success].must_equal "Successfully logged in as existing user userone"
    end
  end
end
