require "test_helper"

describe SessionsController do
  it "gets login page" do
    get login_page_path
    must_respond_with :success
  end

  it "can login a new user" do
    proc {
      post login_page_path, params: {name: users(:mark).name}
    }.must_change 'User.count', 0
  end

  it "can logout" do
    delete login_path
    assert_nil session[:user]
    assert_nil session[:user_id]
    must_redirect_to home_path
  end
end
