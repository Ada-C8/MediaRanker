require "test_helper"

describe UsersController do
  let(:user) { users(:one) }
  let(:existing_auth_hash) { OmniAuth::AuthHash.new(auth_hash(user)) }
  let(:new_auth_hash) { OmniAuth::AuthHash.new(auth_hash_github) }
  let(:invalid_auth_hash) { OmniAuth::AuthHash.new(very_bad_hash) }

  describe "#create" do

    it "logs in an existing user and redirects them back to the homepage" do
      start_count = User.count
      login(user, :github)

      must_respond_with :redirect
      must_redirect_to root_path
      User.count.must_equal start_count
      session[:user_id].must_equal user.id
    end

    it "should not create a new user on repeat logins" do
      proc {
        3.times do
          login(user, "github")
        end
      }.wont_change "User.count"
    end

    it "should create a new user" do
      user = User.new(provider: "github", uid: 9999, username: "newusername", email: "newemail@gmail.com")

      proc {login(user, :github)}.must_change 'User.count', +1
      must_redirect_to root_path
      session[:user_id].must_equal User.find_by(username: "newusername").id
    end

    it "clears the session and redirects back to the root path when a merchant logs out" do
      login(user, :github)
      post logout_path
      session[:user_id].must_equal nil
      must_redirect_to root_path
    end

    it "notifies ther merchant after it logs out" do
      login(user, :github)
      post logout_path
      flash[:status].must_equal :success
      flash[:message].must_equal "You successfully logged out"
    end

  end
end
