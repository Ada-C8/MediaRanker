require "test_helper"

describe UsersController do
  describe "index" do
    it "returns a success status" do
      get users_path
      must_respond_with :success
    end
  end
end
