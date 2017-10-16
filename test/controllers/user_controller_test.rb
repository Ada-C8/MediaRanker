require './test/test_helper'


describe UserController do
  it 'should get index' do
    get users_path
  end
end

=begin
class UserControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get '/users'
    assert_response :success

  end

  test "get user data" do
    get users_path(1)
    must_respond_with :success
  end

end
=end
