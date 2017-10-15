require "test_helper"

describe UsersController do
  let(:west) {users(:west)}
  it "should show all users on the index page" do
    get users_path
    must_respond_with :success
  end

  it "should show the details for a specific user on the show page" do
    get user_path(users(:west).id)
    must_respond_with :success
  end

  it "should get a form to create a new user" do
    get new_user_path
    must_respond_with :success
  end

  it "should be able to create a new user when provided with a name" do
    proc {post users_path, params: {user: {name: "new user"}}}.must_change 'User.count', 1
    must_respond_with :redirect
    must_redirect_to users_path
  end

  it "should not be able to create a new user if no name is provided" do
    proc {post users_path, params: {user: {name: nil}}}.must_change 'User.count', 0
  end

  it "should get and edit form" do
    get edit_user_path(users(:west).id)
    must_respond_with :success
  end

  it "should get a login form" do
    get login_path
    must_respond_with :success
  end

  it "should log a user in when that user already exists" do
    proc { post login_path params: {user: {name: users(:west).name}}}.must_change 'User.count', 0
    session[:logged_in_user].must_equal users(:west)
    must_respond_with :redirect
    must_redirect_to users_path
  end

  it "should create a new user when a non-existent username is entered" do
    proc { post login_path params: {user: {name: "New User!"}}}.must_change 'User.count', 1
    session[:logged_in_user][:name].must_equal "New User!"
    must_respond_with :redirect
    must_redirect_to users_path

  end

  it "should log a user out when prompted to do so" do
    post logout_path
    must_respond_with :redirect
  end

end
