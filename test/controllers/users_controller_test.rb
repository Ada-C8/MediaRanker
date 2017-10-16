require "test_helper"

describe UsersController do
  it "should get index" do
    get users_path
    must_respond_with :success
  end

  it "should get show" do
    user = users(:user_one)
    get user_path(user.id)
    must_respond_with :success
  end

  it "should respond with a 404 if it's not found" do
    #Arrange
    users(:user_one).destroy()

    #Act

    get user_path(users(:user_one).id)

    #Assert

    must_respond_with :not_found
  end

end
