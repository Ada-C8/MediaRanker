require "test_helper"

describe SessionsController do

  let(:fanGirl) { users(:fanGirl) }
  let(:fanBoy) { users(:fanBoy) }

  it "responds to login path" do
    get login_path
    must_respond_with :success
  end

  it "login for existing user" do
    proc {post login_path, params: {name: users(:fanGirl).name}
  }.must_change 'User.count', 0
  session[:name].must_equal users(:fanGirl).name
  session[:user_id].must_equal users(:fanGirl).id
end

it "won't login for invalid user" do
  proc {post login_path, params: {name: nil}}.must_change 'User.count', 0
end

it "will log in new user and increase user count by 1" do
  proc {post login_path, params: {name: "Test name"}}.must_change 'User.count', 1
end

it "successfully logs out user" do
  post logout_path
  session[:name].must_be_nil
  session[:user_id].must_be_nil
  must_redirect_to root_path
end

end
