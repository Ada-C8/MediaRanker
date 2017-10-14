require "test_helper"

describe UsersController do
  describe "index" do
    it " should return success status for all users" do
      get users_path
      must_respond_with :success
    end
    it "should return success when theere are no users" do
      User.destroy_all
      get users_path
      must_respond_with :success
    end
  end

  describe "login_form" do
    it "should return a success" do
      get login_path
      must_respond_with :success
    end
  end

  describe "login" do
    it "returns a success if username exists " do
      get user_path(User.first)
      must_respond_with :success
    end

    it " will successfully log in as an existing user if user exists in db" do

    end

    it "will successfully create new username if username doesn't exist" do
    end
  end
end
