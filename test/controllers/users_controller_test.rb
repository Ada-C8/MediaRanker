require "test_helper"

describe UsersController do

  describe "index" do
    it "returns a success status" do
      get users_path
      must_respond_with :success
    end

    it "returns success status when there are no users" do
      User.destroy_all
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "returns success when given a valid user ID" do
      valid_id = User.first
      get work_path(valid_id)
      must_respond_with :success
    end

    it "returns not_found when given a bogus work ID" do
      bogus_id = User.last.id + 1
      get user_path(bogus_id)
      must_respond_with :not_found
    end
  end


end
