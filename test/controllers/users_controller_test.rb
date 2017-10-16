require "test_helper"

describe UsersController do

  before do
    @valid_user_data = {
      user: {
        name: "Mello Joy",
        joined: Date.today
      }
    }

    User.new(@valid_user_data[:user]).must_be :valid?

    @invalid_user_data = {
      user: {
        name: "",
        joined: Date.today
      }
    }
  end

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
    it "returns a success status when given a valid user ID" do
      user_id = User.first.id
      get user_path(user_id)
      must_respond_with :success
    end

    it "returns a not_found status when given an invalid ID" do
      invalid_user_id = User.first.id + 1
      get user_path(invalid_user_id)
      must_respond_with :not_found
    end

    it "returns a not_found status when given an invalid ID of 0" do
      invalid_user_id = 0
      get user_path(invalid_user_id)
      must_respond_with :not_found
    end

    it "returns a not_found status when given an invalid ID of a string" do
      invalid_user_id = "0"
      get user_path(invalid_user_id)
      must_respond_with :not_found
    end
  end

  describe "login_form" do
    it "returns a success status" do
      get login_path
      must_respond_with :success
    end
  end

  describe "login" do
    it "returns a redirect status when user data is valid (anything but blank)" do
      post login_path, params: @valid_user_data
      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "saves a new user to the database when given valid user data" do
      user_count = User.count
      post login_path, params: @valid_user_data
      User.count.must_equal user_count + 1
    end

    it "sets a session variable to be equal to be an Integer (the new user ID), a flash variable to be equal to :success, and a flash message indicating that the user is logged in" do
      post login_path, params: @valid_user_data
      session[:logged_in_user].must_be_instance_of Integer
      flash[:status].must_equal :success
      flash[:message].must_equal  "#{@valid_user_data[:user][:name]} is successfully logged in"
    end

    it "sets a flash variable to be equal to :failure and the message to indicate to the user to enter a username, if given invalid user data" do
      post login_path, params: @invalid_user_data
      flash[:status].must_equal :failure
      flash[:message].must_equal  "Please enter a username"
    end
  end

  describe "logout" do
    it "redirects to the root_path when a user is logged in" do
      get logout_path
      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "sets a session variable to be equal to nil, a flash variable to be equal to :success, and a flash message indicating that the user is logged out" do
      get logout_path
      session[:logged_in_user].must_equal nil
      flash[:status].must_equal :success
      flash[:message].must_equal "You have been successfully logged out"
    end
  end
end
