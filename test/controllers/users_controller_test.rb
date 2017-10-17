require "test_helper"

describe UsersController do
  describe "index" do
    it "gets a list of users" do
      get users_path
      must_respond_with :success
    end
    it "returns a success stauts when no users" do
      User.destroy_all
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "returns a success when given a valid user id" do
      user_id = User.first.id
      get user_path(user_id)
      must_respond_with :success
    end
    it "returns not found when given an invalid work id" do
      user_id = User.first.id + 1
      get user_path(user_id)
      must_respond_with :not_found
    end
  end

  describe "login" do
    it "redirects to root_path when user is valid" do
      user_data = {
        user: {
          name: "test-user"
        }
      }
      User.new(user_data[:user]).must_be :valid?

      start_user_count = User.count

      post "/login", params: user_data
      must_respond_with :redirect
      must_redirect_to root_path

      User.count.must_equal start_user_count + 1
    end
    it "sends a bad request when user data is invalid" do
      invalid_user_data = {
        user: {
          name: ""
        }
      }
      User.new(invalid_user_data[:user]).wont_be :valid?

      start_user_count = User.count

      post "/login", params: invalid_user_data
      must_respond_with :bad_request

      User.count.must_equal start_user_count
    end
  end

  describe "logout" do
    it "redirects to root_path when log out" do
      # get "/logout"
      # must_respond_with redirect
    end
  end
end
