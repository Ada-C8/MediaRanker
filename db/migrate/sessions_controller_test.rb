require "test_helper"

describe SessionsController do

  describe "auth_callback" do

    it "logs in an existing user and redirects them back to the homepage" do
      start_count = User.count
      user = users(:dee)
      log_in(user, :github)

      must_respond_with :redirect
      must_redirect_to root_path
      User.count.must_equal start_count
      session[:user_id].must_equal user.id
    end

      it "logs in a new user and redirects them back to the homepage" do
        # start_count = User.count
        user = User.new
        user.name = "Newuser"
        user.email = "new@adadev.org"
        user.uid = 111
        user.provider = :github

        OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))


        proc { get auth_callback_path(:github)}.must_change 'User.count', 1
        user = User.find_by(uid: user.uid, provider: user.provider)
        # start_count.must_change 'User.count', 1
        # must_respond_with :redirect
        must_redirect_to root_path
        session[:user_uid].must_equal # Finish this
      end
  end
end
