require "test_helper"

describe UsersController do

  describe "index" do
    it "returns a success status for all users" do
      get users_path
      must_respond_with :success
    end

    it "returns a success status for no users" do
      User.destroy_all
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "returns success when given a valid user ID" do
      valid_user_id = User.first.id
      get user_path(valid_user_id)
      must_respond_with :success
    end

    it "returns not_found when given an invalid user ID" do
      invalid_user_id = User.last.id + 1
      get user_path(invalid_user_id)
      must_respond_with :not_found
    end
  end

end
