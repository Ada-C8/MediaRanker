require "test_helper"

describe UsersController do
  let(:invalid_id) { User.last.id + 1 }

  describe "index" do
    it "should get index" do
      get users_path
      must_respond_with :success
    end

    it "must respond with success if no users" do
      User.destroy_all
      get users_path
      must_respond_with :success
    end
  end

  describe "#show" do
    it "should respond with success if user exists" do
      get user_path(users(:harry))
      must_respond_with :success
    end

    it "should respond with not found if user doesn't exist" do
      get user_path(invalid_id)
      must_respond_with :not_found
    end
  end

  describe "login_form" do
    it "should get login form page" do
      get login_path
      must_respond_with :success
    end
  end

  describe "login" do
    it "should create a new user if user doesn't already exist and log in" do
      new_user_data = {
        user: {
          name: "New User"
        }
      }

      start_count = User.count

      post login_path(new_user_data)

      must_respond_with :redirect
      must_redirect_to root_path
      User.count.must_equal start_count + 1
      session[:user_id].must_equal User.last.id
    end

    it "should find user and log in if user already exists and redirect" do
      existing_user = users(:harry)
      existing_user_data = {
        user: {
          name: existing_user.name
        }
      }
      start_count = User.count

      post login_path(existing_user_data)

      User.count.must_equal start_count
      must_respond_with :redirect
      must_redirect_to root_path
      session[:user_id].must_equal existing_user.id

    end

    it "should return bad request if user info is invalid (somehow gets bad id??)" do
      invalid_user_data = {
        user: {
          name: ""
        }
      }

      post login_path(invalid_user_data)

      must_respond_with :bad_request
      session[:user_id].must_be_nil
    end

  end

  describe "logout" do
    it "should reset user_id to nil and redirect" do
      # log in
      existing_user = users(:harry)
      existing_user_data = {
        user: {
          name: existing_user.name
        }
      }
      post login_path(existing_user_data)

      # double check user is logged in
      session[:user_id].wont_be_nil

      post logout_path

      session[:user_id].must_be_nil
      must_respond_with :redirect
      must_redirect_to root_path
    end

  end

end
