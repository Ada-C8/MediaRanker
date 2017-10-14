require "test_helper"

describe VotesController do
  describe "create" do
    it "redirects to  when the work data is valid" do
      user_data = {
        user: {
          name: "Di",
        }
      }
      #test data should result in valid work if not it will break
      User.new(user_data[:user]).must_be :valid?
      user_count = User.count
      post users_path, params: user_data
      must_respond_with :redirect
      must_redirect_to root_path
      User.count.must_equal user_count + 1
    end

    it "returns bad_request when user data is not valid" do
      user_data = {
        user: {
          name: nil,
        }
      }
      #test data should result in valid work if not it will break
      User.new(user_data[:user]).wont_be :valid?
      user_count = User.count
      post users_path, params: user_data
      must_respond_with :bad_request
      User.count.must_equal user_count
    end
  end
end
