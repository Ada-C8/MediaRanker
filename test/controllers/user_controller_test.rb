require "./test/test_helper"
require 'date'
require './app/helpers/application_helper'

=begin
Read model ID from URL - 2 cases
-valid ID
-invalid ID

controller reads data and adds to DB - 2
-data was valid
-data failed validations

reads data from session - 2 cases
-user logged in
-user not logged in

=end

describe UsersController do
  it "must get index page" do
    get users_path
    must_respond_with :success
  end

  describe 'user id validations' do
    it "get specified valid user" do
      get users_path(users(:one).id)
      must_respond_with :success
    end

    it "get specified invalid user" do
      get user_path(-1)
      must_respond_with :missing
    end
  end

  describe 'Make new user' do
    it 'will create a valid new user' do
      post users_path, params: {
        user: {
          name: 'john',
          joined_on: Date.today
        }
      }
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
end
