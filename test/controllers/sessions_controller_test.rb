require "test_helper"

describe SessionsController do

  describe "#login_form" do
    it "returns success if the user wants to log in" do
      get login_path

      must_respond_with :success
    end
  end

  describe "#create" do
    it "redirects to the root path if the user is found" do
      user_name = User.first.name

      user_data = {
        name: user_name
      }

      post login_path, params: user_data

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "must create a new user if the login name is not found" do
      user_data = {
        name: "This user does not exist yet!"
      }

      post login_path, params: user_data

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "returns a bad_request if the user is not found and the user attributes are invalid" do
      user_data = {
        name: ""
      }

      post login_path, params: user_data

      must_respond_with :bad_request
    end
  end

  describe "#destroy" do
    it "returns redirect if the user is logged out" do
      get logout_path

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

end # Des
