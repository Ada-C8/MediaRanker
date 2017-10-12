require "test_helper"

describe UsersController do
  let(:invalid_id) { -2 }

  it "should get index" do
    get users_path
    must_respond_with :success
  end

  describe "#show" do
    it "should get a show user page" do
      get user_path(users(:harry))
      must_respond_with :success
    end

    it "should return 404 if not found" do
      get user_path(invalid_id)
      must_respond_with :not_found
    end
  end

  it "should get a new user page" do
    get new_user_path
    must_respond_with :success
  end

  describe "#create" do
    let(:user_params) { { name: "New User" } }
    
    it "should create a new user" do
      post create_user_path, params: { user: user_params }

      must_respond_with :redirect
      must_redirect_to users_path
    end

    it "should increase user count" do
      proc { post create_user_path, params: { user: user_params } }.must_change 'User.count', 1
    end

  end

end
