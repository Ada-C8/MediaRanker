require "test_helper"

describe UsersController do

  it "should get to user INDEX" do
    get users_path
    must_respond_with :success
  end

  it "Should be able to acces a SHOW page for a page based on a specific ID" do
    get user_path(users(:one).id)
    must_respond_with :success
  end


  #TODO
  it "should be able to successfully CREATE a user" do
    proc  {
      post users_path, params: {user: {username: "Sample Username"}} }.must_change 'User.count', 1

      must_respond_with :redirect
      must_redirect_to root_path
  end


  it "Should be able to DELETE/DESTROY a user" do
    proc  {
      delete user_path(users(:one).id)}.must_change 'User.count', - 1
      must_redirect_to root_path
  end


  it "Should be able to EDIT a user" do
    put user_path(users(:one)), params: {user: {username: "Updated"} }
    updated_user = User.find(users(:one).id)
    updated_user.username.must_equal "Updated"

    must_redirect_to root_path
  end

end
