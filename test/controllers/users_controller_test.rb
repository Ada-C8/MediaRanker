require "test_helper"

describe UsersController do
  let(:west) {users(:west)}
  it "should get index" do
    get users_path
    must_respond_with :success
  end

  it "should get show" do
    get user_path(users(:west).id)
    must_respond_with :success
  end

  it "should get new" do
    get new_user_path
    must_respond_with :success
  end

  it "should get create" do
    # count = users.count
    post users_path, params: {user: {name: "new user"}}
    must_respond_with :redirect
    must_redirect_to users_path
    # users.count.must_equal count+1
  end

  it "should get edit" do
    get edit_user_path(users(:west).id)
    must_respond_with :success
  end

  it "should get update" do
    patch user_path(users(:west).id), params: {user: {name: "Update User"}}
    must_respond_with :redirect
    must_redirect_to user_path
  end

  it "should get a login form" do
    get login_path
    must_respond_with :success
  end

  it "should log a user in when that user already exists" do
    proc { post login_path params: {user: {name: users(:west).name}}}.must_change 'User.count', 0

    must_respond_with :redirect
    must_redirect_to users_path
  end

  it "should create a new user when a non-existent username is entered" do
    proc {post login_path params: {user: {name: "New User!"}}}.must_change 'User.count', 1
    must_respond_with :redirect
    must_redirect_to users_path

  end

  it "should log a user out when prompted to do so" do
    post logout_path
    must_respond_with :redirect
  end

end
