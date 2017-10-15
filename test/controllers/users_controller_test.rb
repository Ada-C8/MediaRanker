require "test_helper"

describe UsersController do
  it "should get index" do
    get users_path
    must_respond_with :success
  end

  it "should get show" do
    get user_path(users(:one).id)
    must_respond_with :success
  end

  # it "should get new" do
  #   get new_user_path
  #   value(response).must_be :success?
  # end
  it "should get login_form" do
    get login_path
    must_respond_with :success
  end

  it "login should set a session if user already exists" do
    post login_path, params: { name: users(:one).name }
    session[:user_id].must_equal users(:one).id

    must_redirect_to root_path
  end

  it "login should create a new user if username does not yet exist" do
    proc {
      post login_path, params: { name: "bob" }
    }.must_change 'User.count', 1

    must_respond_with :redirect
    must_redirect_to root_path
  end

  it "logs out" do
    post login_path, params: { name: users(:two).name }
    session[:user_id].must_equal users(:two).id

    post logout_path
    session[:user_id].must_equal nil
  end

end
