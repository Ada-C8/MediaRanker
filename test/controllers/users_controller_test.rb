require "test_helper"

describe UsersController do
  describe "index" do
    it "returns a success status for all users" do
      get users_path
      must_respond_with :success
    end

    it "returns a success status for no users" do
      Work.destroy_all
      get users_path
      must_respond_with :success
    end
  end

  describe "login_form" do
    it "returns a success status" do
      get login_path
      must_respond_with :success
    end
  end

  describe "login" do
    # it "creates a new user if user didn't exist" do
    #
    # end

    it "logs in user if user did exist" do
      login_data = {
        user: {
        name: "Bennett"
        }
      }
      User.find_by(name: login_data[:user][:name]).must_equal users(:bennett)

      post login_path, params: login_data
      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "sends error if no name given" do
      login_data = {
        user: {
        name: ""
        }
      }
      User.new(login_data[:user]).wont_be :valid?

      post login_path, params: login_data
      must_respond_with :bad_request

    end
  end


end
