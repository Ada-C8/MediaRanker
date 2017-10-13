require "test_helper"

describe UsersController do

  let(:good_id) { User.first.id }
  let(:bad_id) { User.last.id + 1 }

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

  describe 'process-login' do
    it '' do
      
    end
  end
end
