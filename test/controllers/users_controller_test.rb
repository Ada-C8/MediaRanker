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

end
