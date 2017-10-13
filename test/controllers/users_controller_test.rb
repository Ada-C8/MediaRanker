require "test_helper"

describe UsersController do

  let(:good_id) { User.first.id }
  let(:bad_id) { User.last.id + 1 }
  let(:user) { User.new(name: 'test') }
  let(:existing_params) { { username: 'test' } }
  let(:new_params) { { username: 'new' } }

  describe 'index' do
    it 'responds with success with full database' do
      get users_path

      must_respond_with :success
    end

    it 'responds with success with empty database' do
      User.destroy_all

      get users_path

      must_respond_with :success
    end
  end

  describe 'show' do
    it 'responds with success if user exists' do
      get user_path(good_id)

      must_respond_with :success
    end

    it 'responds with not_found if user does not exist' do
      get user_path(bad_id)

      must_respond_with :not_found
    end
  end

  describe 'login' do
    it 'responds with success' do
      get login_path

      must_respond_with :success
    end
  end

  describe 'process-login' do
    it 'logs user in if user exists' do
      user.save

      post login_path(existing_params)

      must_respond_with :found

      session[:user].must_equal user
    end

    it 'creates new user if user does not exist' do
      before_count = User.count

      post login_path(new_params)

      session[:user].name.must_equal 'new'

      must_respond_with :found

      User.count.must_equal (before_count + 1)
    end
  end
end
