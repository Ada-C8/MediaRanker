require "test_helper"

describe UsersController do
  it "should successfully get to users index page" do
    get users_path
    must_respond_with :success
  end

  it "should successfully get to user show page" do
    get user_path(users(:test_user).id)
    must_respond_with :success
  end

  it "should be able to create a new user" do
    post users_path, params: {user: {username: "testingitout"}}
    must_respond_with :redirect
    must_redirect_to users_path

    proc   {
      post users_path, params: {user: {username: "checkingitout"}}
    }.must_change 'User.count', 1
  end

  it "should redirect to users index if you try to access a user that does not exist" do
    get user_path(299876)
    must_respond_with :redirect
    must_redirect_to users_path
  end

end
