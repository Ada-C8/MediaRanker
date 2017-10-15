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
    it " will successfully log in as an existing user" do
      post login_path, params: { username: User.first.username }
      must_redirect_to root_path
    end

    it " successfully creates new username if username doesn't exist" do
      post login_path, params: { username: User.last.username }
      must_redirect_to root_path
    end

    # it "should fail when no name is given" do
    #   post login_path
    #   must_respond_with :no_content
    # end
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

  describe "logout" do
    it "successfully logs out a user" do
      post login_path, params: { name: User.first.name }
      get logout_path
      must_redirect_to root_path
    end
  end
end
