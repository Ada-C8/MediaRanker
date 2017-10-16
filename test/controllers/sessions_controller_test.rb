require "test_helper"

describe SessionsController do

it "going to the login_form page is successful" do
  get login_path
  must_respond_with :success
end

it "should be able to create a user" do
  skip
  proc {
    post login_path, params: {username: "alyssa"}
  }.must_change 'User.count', 1
  must_respond_with :redirect
  must_redirect_to root_path
end

it "should be able to login as an existing user" do
  proc {
    post login_path, params: {username: users(:crisco).name}
  }.must_change 'User.count', 0
  must_respond_with :redirect
  must_redirect_to root_path
  session[:user_id].must_equal users(:crisco).id
end

end
