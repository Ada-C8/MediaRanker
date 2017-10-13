require "test_helper"

describe UsersController do
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
    post users_path, params: {works: {name: "new user"}}
    must_respond_with :redirect
    must_redirect_to :users_path
  end

  it "should get destroy" do
    delete user_path(users(:west).id)
    must_respond_with :redirect
    must_redirect_to :users_path
  end

  it "should get edit" do
    get edit_user_path(users(:west).id)
    must_respond_with :success
  end

  it "should get update" do
    patch user_path(users(:west).id), params: {works: {name: "Update User"}}
    must_respond_with :redirect
    must_redirect_to :users_path
  end

end
