require "test_helper"

describe UsersController do
  it "should go to the index page" do
    get users_path
    must_respond_with :success
  end

  it "should visit a user's show page" do
    get user_path(users(:susie).id)
    must_respond_with :success
  end

  it "should create a work" do
    proc {
      post users_path, params: { user: {username: "Slimer"}}
    }.must_change 'User.count', 1

    must_respond_with :redirect
    must_redirect_to users_path
  end
end
