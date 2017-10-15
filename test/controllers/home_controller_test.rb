require "test_helper"

describe HomeController do
  describe "index" do
    it "returns a success status for root_path" do
      get root_path
      must_respond_with :success
    end

    it "returns a success status for no works" do
      Work.destroy_all
      User.destroy_all
      Vote.destroy_all
      get users_path
      must_respond_with :success
    end
  end
end
