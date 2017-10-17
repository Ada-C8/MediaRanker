require "test_helper"

describe UsersController do

  describe "index" do
    it "gets index and returns a success status for all users" do
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
    it "returns success when given a valid user id" do
      user_id = User.first.id
      get user_path(user_id)
      must_respond_with :success
    end

    it "returns not_found when given an invalid user id" do
      invalid_user_id = User.last.id + 1
      get user_path(invalid_user_id)
      must_respond_with :not_found
    end
  end

  describe "login" do
    it "logs in a new user and redirects to root" do
      login_params = {
        user: {
          username: "test",
          date_joined: Date.today
        }
      }
      post login_path(login_params)
      user = User.find_by(username: login_params[:user][:username])
      session[:logged_in_user].must_equal user.id

      must_redirect_to root_path
    end

    it "logs in an existing user and redirects to root" do
      user = User.first
      login_params = {
        user: {
          username: user.username,
          date_joined: user.date_joined
        }
      }
      post login_path(login_params)
      session[:logged_in_user].must_equal user.id

      must_redirect_to root_path
    end

    it "does not allow logging in with invalid info (e.g., no username)" do
      login_params = {
        user: {
          date_joined: Date.today
        }
      }
      post login_path(login_params)

      session[:logged_in_user].must_equal nil
      must_respond_with :bad_request
    end
  end

  describe "logout" do
    it "redirects to root path when user logs out" do
      login_params = {
        user: {
          username: "test",
          date_joined: Date.today
        }
      }
      post login_path(login_params)
      post logout_path
      session[:logged_in_user].must_be_nil

      must_redirect_to root_path
    end

  end
end
