require "test_helper"

describe UsersController do
  describe "index" do
    it "gets a list of users" do
      get users_path
      must_respond_with :success
    end
    it "returns a success stauts when no users" do
      User.destroy_all
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "returns a success when given a valid user id" do
      user_id = User.first.id
      get user_path(user_id)
      must_respond_with :success
    end
    it "returns not found when given an invalid work id" do
      user_id = User.first.id + 1
      get user_path(user_id)
      must_respond_with :not_found
    end
  end

end
