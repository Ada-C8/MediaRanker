require "test_helper"

describe UsersController do
  describe "#index" do
    it "returns success when all Users are valid" do
      get users_path

      must_respond_with :success
    end

    it "returns success when there are no Users" do
      User.destroy_all

      get users_path

      User.count.must_equal 0
      must_respond_with :success
    end
  end # Des

  describe "#show" do
    it "returns success if a user exists" do
      get user_path(User.first.id)

      must_respond_with :success
    end

    it "returns not found if the user_id does not exist" do
      get user_path(User.last.id + 1)

      must_respond_with :not_found
    end
  end # Des

end # Des
