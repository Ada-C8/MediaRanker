require "test_helper"

describe UsersController do
  let(:user) { users(:one) }

  describe "auth_callback" do
    it "logs in an existing user" do
      start_count = User.count

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

  describe "validation" do

    it "must have a username" do
    user.valid?.must_equal true
    user.username = nil
    user.valid?.must_equal false
    user.save
    user.errors.keys.must_include :username
  end

    it "must have a unique username" do
      user.username = "Wally"
      user.valid?.must_equal false
    end

    it "must have an email address" do
      user.valid?.must_equal true
      user.email = nil
      user.valid?.must_equal false
      user.save
      user.errors.keys.must_include :email
    end

    it "must have a unique email" do
      user.valid?.must_equal true
      user.email = "walter@gmail.com"
      user.valid?.must_equal false
    end

    it "should return false without a UID" do
      user.valid?.must_equal true
      user.uid = nil
      user.valid?.must_equal false
    end

    it "should return false without a provider" do
      user.valid?.must_equal true
      user.provider = nil
      user.valid?.must_equal false
    end

    it "should return false if provider is not 'github'" do
      user.valid?.must_equal true
      user.provider = "not github"
      user.valid?.must_equal false
    end

    it "should return false with a non-unique UID & provider" do
      user2 = User.new(uid: user.uid, provider: user.provider)
      user2.valid?.must_equal false
    end
  end



  describe "self.from_auth_hash" do
    let(:existing_auth_hash) { OmniAuth::AuthHash.new(auth_hash(user)) }
    let(:new_auth_hash) { OmniAuth::AuthHash.new(auth_hash_github) }
    let(:invalid_auth_hash) { OmniAuth::AuthHash.new(very_bad_hash) }

    # it "should return an existing users" do
    #   proc {
    #     User.from_auth_hash("github", existing_auth_hash).must_equal user
    #   }.wont_change "User.count"
    # end

    it "should create and return new users" do
      proc {
        new_user = User.from_auth_hash("github", new_auth_hash)

        new_user.must_be_kind_of User
        new_user.save.must_equal true
      }.must_change "User.count", 1
    end

    it "should not create a user if auth hash is invalid" do
      proc {
        invalid_user = User.from_auth_hash("github", invalid_auth_hash)

        invalid_user.must_be_kind_of User
        invalid_user.valid?.must_equal false
        invalid_user.save.must_equal false
      }.wont_change "User.count"
    end
  end
  #
  # describe "#trainer" do
  #   let(:user) { users(:user_with_trainer) }
  #
  #   it "should return the associated trainer" do
  #     user.trainer.must_equal trainers(:misty)
  #   end
  #
  #   it "should return nil with no associated trainer" do
  #     users(:github_user).trainer.must_be_nil
  #   end
  # end
end
