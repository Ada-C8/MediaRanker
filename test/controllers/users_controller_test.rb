require "test_helper"

describe UsersController do
  describe "index" do
    it "will return success" do
      get users_path
      must_respond_with :success
    end # success
  end # index

  describe "show" do
    it "will return success if given a valid user id" do
      id = User.first.id
      get user_path(id)
      must_respond_with :success
    end # success

    it "will return not_found when given an invalid user id" do
      invalid_id = User.last.id + 1
      get user_path(invalid_id)
      must_respond_with :not_found
    end # not_found
  end # show

  describe "login" do
    it "will login to a exitsing user if given an existing name" do
      # Arrange
      user_data = {
        user: {
          name: User.first.name
        }
      }
      # check that user exists
      user = User.first
      user.wont_be_nil
      # Act
      post login_path, params: user_data
      # Assert
      # TODO: Figure out why this is failing!!! My flash message shows the right user id, so I'm not sure what is happening here
      session[:logged_in_user].must_equal user.id
    end # will log into existing user

    it "Will create a new User if given a new name" do
      # Arrange
        # create user data
        user_data = {
          user: {
            name: "This is a test name"
          }
        }
        #check that user doesn't exist in DB
        user = User.find_by(name: user_data[:user][:name])
        user.must_equal nil
        #count the current number of users
        number_of_users = User.count

      # Act
        post login_path, params: user_data

      # Assert
        User.count.must_equal number_of_users + 1
    end # create new User for new name
  end # login

end # UsersController
