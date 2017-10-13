require "test_helper"

describe UsersController do
  let :user_data {
    user_data = {
      user: {
        username: "Sarah"
      }
    }
  }
  let :bad_user_data {
    bad_user_data = {
      user: {
        username: ""
      }
    }
  }
  let :user_id { User.last.id }

  describe "index" do
    it "returns a success status" do
      get users_path
      must_respond_with :success
    end

    it "returns a success status when there are no users" do
      User.destroy_all
      get users_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "redirects to the users_path if the user data is valud and adds a user to the db" do
      # # Arrange
      # test if work is valid
      User.new(user_data[:user]).must_be :valid?
      user_count = User.count
      # # Act
      post users_path, params: user_data
      # # Assert
      must_respond_with :redirect
      must_redirect_to users_path
      User.count.must_equal user_count + 1
    end

    it "returns bad_request status when the user data is invalid" do
      # # Arrange
      User.new(bad_user_data[:user]).wont_be :valid?
      user_count = User.count
      # # Act
      post users_path, params: bad_user_data
      # # Assert
      must_respond_with :bad_request
      User.count.must_equal user_count
    end
  end

  describe "show" do
    it "returns success when given a valid user ID" do
      get user_path(user_id)
      must_respond_with :success
    end

    it "returns not_found when given a bad user ID" do
      get user_path(user_id + 1)
      must_respond_with :not_found
    end
  end
end
