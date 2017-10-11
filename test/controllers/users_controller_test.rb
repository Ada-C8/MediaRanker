require "test_helper"

describe UsersController do
  let(:user) {users(:megan)}
  it "should get index" do
    get users_path
    value(response).must_be :success?
  end

  it "should get show" do
    get user_path(user.id)
    value(response).must_be :success?
  end

  it "should render 404 page if not found" do
    get user_path(-1)
    assert_response 404
  end

end
