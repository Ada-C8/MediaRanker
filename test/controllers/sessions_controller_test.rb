require "test_helper"

describe SessionsController do

  let(:before_count) { User.count }

  describe "#login_form" do
    it "returns success if the user form is requested" do
      get login_path

      must_respond_with :success
    end
  end

  describe "#create" do
    it "redirects to the root path if the user is found" do
      before_count
      user_name = User.first.name
      user_data = {
        name: user_name
      }

      post login_path, params: user_data

      must_respond_with :redirect
      session[:logged_in_session].must_equal User.first.id
      must_redirect_to root_path
      User.count.must_equal before_count
    end

    it "must create a new user if the login name is not found" do
      before_count
      user_data = {
        name: "This user does not exist yet!"
      }

      post login_path, params: user_data

      must_respond_with :redirect
      must_redirect_to root_path
      User.count.must_equal before_count + 1
    end

    it "returns a bad_request if the user is not found and the user attributes are invalid" do
      before_count
      user_data = {
        name: ""
      }

      post login_path, params: user_data

      must_respond_with :bad_request
      User.count.must_equal before_count
    end
  end

  describe "#destroy" do
    it "returns redirect if the user is logged out successfully" do
      get logout_path

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "returns a blank session when logged out" do
      user_name = User.first.name
      user_data = {
        name: user_name
      }

      post login_path, params: user_data
      get logout_path

      session[:logged_in_session].must_equal nil
    end
  end

end # Des
