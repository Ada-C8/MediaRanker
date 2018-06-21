require "test_helper"

describe UsersController do
  describe "index" do
    it "returns a success status for all users" do
      get users_path
      must_respond_with :success
    end

    it "returns a success status when there are no users" do
      User.destroy_all
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "returns a success status when passed a valid id" do
      user_id = User.first.id
      get user_path(user_id)
      must_respond_with :success
    end

    it "returns not_found when given a bogus work id" do
      bad_user_id = User.last.id + 1
      get user_path(bad_user_id)
      must_respond_with :not_found
    end
  end

  describe "create" do
    it "redirects to root_path when the work data is valid" do
      user_data = {
        user: {
          name: "Di",
        }
      }
      #test data should result in valid work if not it will break
      User.new(user_data[:user]).must_be :valid?
      user_count = User.count
      post users_path, params: user_data
      must_respond_with :redirect
      must_redirect_to root_path
      User.count.must_equal user_count + 1
    end

    it "returns bad_request when user data is not valid" do
        user_data = {
          user: {
            name: nil,
          }
        }
        #test data should result in valid work if not it will break
        User.new(user_data[:user]).wont_be :valid?
        user_count = User.count
        post users_path, params: user_data
        must_respond_with :bad_request
        User.count.must_equal user_count
    end
  end
end
