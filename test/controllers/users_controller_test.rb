require "test_helper"

describe UsersController do
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
      new_username = "new username"
      # # Act
      post login_path, params: { username: "new username" }
      # # Assert
      session[:logged_in_user].username.must_equal new_username
      must_respond_with :found
      must_redirect_to root_path
      User.count.must_equal before_count + 1
    end

    it "for a user that does not exist it will not create and login a new user if given bad data" do
      # # Arrange
      before_count = User.count
      bad_new_username = ""
      # # Act
      post login_path, params: { username: bad_new_username }
      # # Assert
      must_respond_with :bad_request
      User.count.must_equal before_count
      session[:logged_in_user].must_be :nil?
    end
  end

  describe "logout" do
    it "logs a user out form a session and redirects to root_path" do
      # # Arrange
      new_username = "new username"
      post login_path, params: { username: new_username }
      session[:logged_in_user].username.must_equal new_username
      # # Act
      post logout_path
      # # Assert
      session[:logged_in_user].must_be :nil?
      must_respond_with :found
    end
  end
end
