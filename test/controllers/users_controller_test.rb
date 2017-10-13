require "test_helper"

describe UsersController do
  it " should return a success for all users" do
    get users_path
    must_respond_with :success
  end
  it "should return success when theere are no users" do
    User.destroy_all
    get users_path
    must_respond_with :success
  end
end
