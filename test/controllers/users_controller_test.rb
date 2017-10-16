require "test_helper"

describe UsersController do

  it "successfully loads works index page to list all works" do
    get users_path
    must_respond_with :success
  end

  it "successfully loads an individual users' voting summary (#show)page" do
    get user_path( users(:jane).id )
    must_respond_with :success
  end

  it "renders 404 page if user#show page is not found" do
    get user_path(0)
    must_respond_with :not_found
  end

  it "successfully loads login form" do
    get login_path
    must_respond_with :success
  end

  it "won't login for invalid user" do
    proc {
      post login_path, params: {name: nil}
    }.must_change 'User.count', 0

    must_respond_with :success
    #must_respond_with :error
  end

  it "sucessfully logs in for an existing user" do
    proc {
      post login_path, params: {username: users(:jane).username}
    }.must_change 'User.count', 0

    must_redirect_to root_path
  end

  it "sucessfully logs in for new user" do
    proc {
      post login_path, params: {username: "UserX"}
    }.must_change 'User.count', 1

    must_redirect_to root_path
  end

  it "will log out a user" do
    delete login_path
    must_redirect_to root_path
  end
end
