require "test_helper"

describe SessionsController do
  let(:user1) { users(:user1) }

  it "should got to login page" do
    get login_path
    must_respond_with :success
  end

  describe "if a user exists" do
    it "should find the user, pass the user to session and redirect" do
      post login_path, params: { name: user1.username }
      session[:logged_in_as_user].must_equal user1.id
      must_respond_with :redirect
    end
  end

  describe "if the user doesn't exist" do
    it "should have an error in session" do
      post login_path, params: { name: nil }
      session[:errors].empty?.must_equal false
      must_respond_with :redirect
    end
  end

  it "should logout a user" do
    get logout_path
    session[:logged_in_as_user].must_be_nil
    must_respond_with :redirect
  end
end
