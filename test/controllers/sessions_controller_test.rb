require "test_helper"

describe SessionsController do

it "going to the login_form page is successful" do
  get login_path
  must_respond_with :success
end

it "should be able to create a user" do
  proc {
    post login_path, params: {user: {name: "alyssa"}}
  }.must_change 'User.count', 1
  must_respond_with :redirect
  must_redirect_to root_path
end

# it "should be able to login as an existing user" do
#
# end

end
