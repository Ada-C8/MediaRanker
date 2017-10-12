require "test_helper"

describe 'UsersController' do
  it 'creates a new user' do
    proc {
      post users_path, params: { user: { username: "new_user"}}}.must_change 'User.count', 1

    must_respond_with :redirect
    must_redirect_to root_path
  end
  it 'renders new if user fails to save' do
    proc {
      post users_path, params: { user: {username: nil}}}.must_change 'User.count', 0

    must_respond_with :success
  end
end
