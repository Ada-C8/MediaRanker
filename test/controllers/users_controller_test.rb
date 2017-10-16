require "test_helper"

describe UsersController do
 let(:user) {users(:cat)}
  describe 'index' do


    it "should get index" do
      get users_path
      must_respond_with :success
    end
  end

  describe 'show' do

    it "should get show" do
      get users_path(user.id)
      value(response).must_be :success?
    end

    it "should show one user" do
      get user_path(users(:cat))
      must_respond_with :success
    end


  end


end
