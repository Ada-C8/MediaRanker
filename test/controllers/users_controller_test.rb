require "test_helper"

describe UsersController do
  describe "index" do
    it "returns success for all users" do
      get users_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "adds user to the database and redirects when the user data is valid" do
      user_data = {
        user: {
          name: "Giorno Giovanna",
          join_date: DateTime.now
        }
      }
      User.new(user_data[:user]).must_be :valid?
      start_user_count = User.count

      post users_path, params: user_data

      must_respond_with :redirect
      must_redirect_to root_path
      User.count.must_equal start_user_count + 1
    end

    it "re-renders form when the work data is invalid" do
      user_data = {
        user: {
          name: ""
        }
      }
      User.new(user_data[:user]).wont_be :valid?
      start_user_count = User.count

      post users_path, params: user_data

      must_respond_with :bad_request
      User.count.must_equal start_user_count
    end
  end

  describe "show" do
    it "returns success with valid id" do
      user_id = User.first.id
      get user_path(user_id)
      must_respond_with :success
    end

    it "returns not_found with invalid id" do
      invalid_id = User.last.id + 1
      get user_path(invalid_id)
      must_respond_with :not_found
    end
  end

  # describe "edit" do
  # end
  #
  # describe "update" do
  # end
  #
  # describe "destroy" do
  # end
  #
  # describe "login" do
  # end
  #
  # describe "logout" do
  # end
end
