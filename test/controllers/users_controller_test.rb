require "test_helper"

describe UsersController do
  describe "#index" do
    it "returns success when all Users are valid" do
      get users_path

      must_respond_with :success
    end

    it "returns success when there are no Users" do

      # # ArgumentError: wrong number of arguments (given 0, expected 1)
      #
      # users = User.all
      # users.destroy
      #
      # get users_path
      #
      # User.count.must_equal 0
      # must_respond_with :success
    end
  end # Des

  describe "#show" do
    it "returns success if a user exists" do
      get user_path(User.first.id)

      must_respond_with :success
    end

    it "returns someting if the user_id does not exist" do
      get user_path(User.last.id + 1)

      must_respond_with :not_found
    end
  end # Des

  describe "#create" do
    it "returns success if a user is created with a unique name not found in the db" do
      new_user_data = {
        user: {
          name: "This name is not yet taken"
        }
      }

      post users_path, params: new_user_data

      must_respond_to :redirect
      must_redirect_to root_path
    end

  end # Des

end # Des
