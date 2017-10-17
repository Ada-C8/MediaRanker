require "test_helper"

describe UsersController do
  it "can successfully load an index page" do
    get users_path
    must_respond_with :success
  end

  it "can successfuly load an individual user page" do
    user = User.find(users(:jake).id)
    get user_path(user.id)
    must_respond_with :success
  end

end
