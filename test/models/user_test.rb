require "test_helper"

describe UsersController do


  describe "auth_callback" do
    it "logs in an existing user" do
      start_count = User.count
      user = users(:one)

      login(user, :github)
      must_redirect_to root_path
      session[:user_id].must_equal user.uid
      session[:user_id].must_equal  User.last.uid 

      User.count.must_equal start_count
    end

    it "creates a new user" do
      start_count = User.count
      user = User.new(provider: "github", uid: 666, username: "not_marcel", email: "weonlylikemarcel@user.com")

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))
      get auth_callback_path(:github)

      must_redirect_to root_path

      User.count.must_equal start_count + 1

      session[:user_id].must_equal user.uid
      session[:user_id].must_equal User.last.uid
    end

    it "redirects to the login route if given invalid user data" do
    end
  end
end
