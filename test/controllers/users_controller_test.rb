require "test_helper"

describe UsersController do
  describe "index" do
    it "returns success for all users" do
      get users_path
      must_respond_with :success
    end
  end

  describe "new" do
    it "returns success for a new work" do
      # get new_user_path
      # must_respond_with :success
    end
  end

  describe "create" do
  end

  describe "show" do
  end

  describe "edit" do
  end

  describe "update" do
  end

  describe "destroy" do
  end
end
