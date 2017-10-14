require "test_helper"

describe UsersController do

  describe "index" do
    it "returns a success status" do
      get users_path
      must_respond_with :success
    end

    it "returns success status when there are no users" do
      User.destroy_all
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "returns success when given a valid user ID" do
      valid_id = User.first
      get work_path(valid_id)
      must_respond_with :success
    end

    it "returns not_found when given a bogus work ID" do
      bogus_id = User.last.id + 1
      get user_path(bogus_id)
      must_respond_with :not_found
    end
  end

  describe "login" do
    it "adds a user to the DB and redirects when user data is valid and unique" do
      valid_user_data = {
        user: {
          name: "example name"
        }
      }
      start_user_count = User.count
      User.new(valid_user_data[:user]).must_be :valid?
      post login_path, params: valid_user_data
      must_respond_with :redirect
      must_redirect_to root_path
      User.count.must_equal start_user_count + 1
    end

    it "does not add a user to the DB and redirects when the user data is valid and not unique" do
      repeat_user_data = {
        user: {
          name: "Bob"
        }
      }
      start_user_count = User.count
      User.new(repeat_user_data[:user]).must_be :valid?
      post login_path, params: repeat_user_data
      must_respond_with :redirect
      User.count.must_equal start_user_count
    end


    it "does not add a user to the DB when the user data is bogus" do
      bogus_user_data = {
        user: {
          name: ""
        }
      }
      start_user_count = User.count
      User.new(bogus_user_data[:user]).wont_be :valid?
      post login_path, params: bogus_user_data
      must_respond_with :bad_request
      User.count.must_equal start_user_count
    end
  end

  describe "logout" do
    it "resets session and redirect back" do
      get logout_path
      must_respond_with :redirect
      session[:logged_in_user].must_equal nil
    end
  end

end
