require "test_helper"

describe UsersController do
  let :user_data {
    user_data = {
      user: {
        username: "Sarah"
      }
    }
  }
  let :bad_user_data {
    bad_user_data = {
      user: {
        username: ""
      }
    }
  }
  let :user_id { User.last.id }
  let(:user) { User.new(username: 'test username') }

  describe "index" do
    it "responds with success " do
      get users_path
      must_respond_with :success
    end

    it "responds with a success status when there are no users" do
      User.destroy_all
      get users_path
      must_respond_with :success
    end
  end

  # describe "create" do
  #   it "redirects to the users_path if the user data is valud and adds a user to the db" do
  #     # # Arrange
  #     # test if work is valid
  #     User.new(user_data[:user]).must_be :valid?
  #     user_count = User.count
  #     # # Act
  #     post users_path, params: user_data
  #     # # Assert
  #     must_respond_with :redirect
  #     must_redirect_to users_path
  #     User.count.must_equal user_count + 1
  #   end
  #
  #   it "returns bad_request status when the user data is invalid" do
  #     # # Arrange
  #     User.new(bad_user_data[:user]).wont_be :valid?
  #     user_count = User.count
  #     # # Act
  #     post users_path, params: bad_user_data
  #     # # Assert
  #     must_respond_with :bad_request
  #     User.count.must_equal user_count
  #   end
  # end

  describe "show" do
    it "returns success when given a valid user ID" do
      get user_path(user_id)
      must_respond_with :success
    end

    it "returns not_found when given a bad user ID" do
      get user_path(user_id + 1)
      must_respond_with :not_found
    end
  end

  # I'm not sure I need this test since I don't actually have a controller action but I put it in because there is a route for it. I am still not confident I understand what and how to test things so an example (maybe book?) of a full suite of controller tests would be so helpful for reference.

  describe "login_form" do
    it "it returns success status" do
      get login_path
      must_respond_with :success
    end
  end

  describe "login" do
    # I'm going to test create via login I'm not sure this is correct. Should I test create on its own? Testing in both places would seem redundant
    it "for a preexisting user it will login the user" do
      # # Arrange
      user.save #saving user gives us a user.id
      # # Act
      post login_path, params: { username: user.username }
      # # Assert
      session[:logged_in_user].must_equal user
      must_respond_with :found
      must_redirect_to root_path
    end

    it "for a user that does not exist it will create and login a new user if given valid data" do
      # # Arrange
      before_count = User.count
      new_user_name = "new username"
      # # Act
      post login_path, params: { username: new_user_name }
      # # Assert
      session[:logged_in_user].username.must_equal new_user_name
      must_respond_with :found
      must_redirect_to root_path
      User.count.must_equal before_count + 1
    end

    it "for a user that does not exist it will not create and login a new user if given bad data" do

    end
  end
end
