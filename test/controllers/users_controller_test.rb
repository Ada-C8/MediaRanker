require "test_helper"

describe UsersController do

  describe "index" do
    it "returns a success status for all users" do
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

  end
end
