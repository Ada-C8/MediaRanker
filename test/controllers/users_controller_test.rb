require "test_helper"

describe UsersController do
  let :user_id { User.last.id }


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

  describe "show" do
    it "returns success when given a vaild id" do
      get user_path(user_id)
      must_respond_with :success
    end
    it "returns not_found when given an invaild id" do
      get user_path(user_id + 1)
      must_respond_with :not_found
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

    it "creates a new user if any other name given" do
      login_data = {
        user: {
        name: "new person"
        }
      }
      User.new(login_data[:user]).must_be :valid?
      start_count = User.all.count

      post login_path, params: login_data
      must_respond_with :redirect
      must_redirect_to root_path
      User.all.count.must_equal start_count + 1

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
