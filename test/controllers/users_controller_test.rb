require "test_helper"

describe UsersController do

  describe "index" do
    it "shows all users" do
      get users_path
      must_respond_with :success
    end

    it "does not error even if there are zero users" do
      Work.destroy_all
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "sucessfully shows a user" do
      get user_path(User.first.id)
      must_respond_with :success
    end
    it "does not show a user that does not exist" do
      get user_path(User.last.id + 1)
      must_respond_with :not_found
    end
  end

  describe "login" do
    it "sucessfully logs in a known user" do
      post login_path, params: { name: User.first.name }
      must_redirect_to root_path
    end
  end

  describe "create" do
    it "creates a new user" do
      post login_path, params: { name: User.last.name }
      must_redirect_to root_path
    end

    it "appropriately fails when no name is given" do
      post login_path
      must_respond_with :no_content
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
