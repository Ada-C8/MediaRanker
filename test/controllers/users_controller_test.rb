require "test_helper"

describe UsersController do
  describe "index" do
    it " should return success status for all users" do
      get users_path
      must_respond_with :success
    end
    it "should return success when there are no users" do
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

    it "will send an error if no name given" do
      login_user = {
        user: {
          username: ''
        }
      }
      User.new(login_user[:user]).wont_be :valid?

      post login_path, params: login_user
      must_respond_with :redirect
      must_redirect_to login_path
    end

    it " will successfully log in as an existing user" do
      login_user = {
        user: {
        username: "sa"
        }
      }
      User.find_by(username: login_user[:user][:username]).must_equal users(:user1)

      post login_path, params: login_user
      must_respond_with :redirect
      must_redirect_to root_path

    end

    it " successfully creates new username if username doesn't exist" do
      new_username = {
        user: {
        username: "new_user"
        }
      }
      User.new(new_username[:user]).must_be :valid?
      start_count = User.all.count

      post login_path, params: new_username
      must_respond_with :redirect
      must_redirect_to root_path
      User.all.count.must_equal start_count + 1
    end
  end

  describe "show" do
    it "successfully shows a user" do
      get user_path(User.first.id)
      must_respond_with :success
    end

    it "does not show a user that does not exist" do
      get user_path(User.last.id + 1)
      must_respond_with :not_found
    end
  end
end
