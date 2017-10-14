require "test_helper"

describe UsersController do
  it "should get index" do
    get users_path
    must_respond_with :success
  end

  it "should get show" do
    user = users(:user_one)
    get user_path(user.id)
    must_respond_with :success
  end

end
