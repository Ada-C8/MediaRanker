require 'test_helper'

describe "UserController" do

  describe "Routing users as expected" do
    it "should successfully routes to index" do
      get users_path
      must_respond_with :success
    end

    it "should successfully routes to show" do
      get user_path(users(:user1).id)
      must_respond_with :success
    end

    it "it won't route to show for an id that doesn't exist" do
      id = users(:user2).id
      delete user_path(id)
      get user_path(id)
      must_redirect_to users_path
    end

    it "should successfully route to new" do
      get new_user_path
      must_respond_with :success
    end


    it "should successfully route to edit" do
      get edit_user_path(users(:user1).id)
      must_respond_with :success
    end


  end

  describe "Changes to the database" do

    it "can create a new user" do
      proc { post users_path, params: { user: {username: "george"}  }}.must_change 'User.count', 1
      must_respond_with :redirect
    end

    it "won't create a new user when parameters are missing" do
      proc { post users_path, params: { user: {username: ""} }}.must_change 'User.count', 0
      must_respond_with :success
    end

    it "can update a user" do
      put user_path(users(:user1).id), params: {user: {username: "Minie"} }

      # find the user with that ID in the database
      user = User.find(users(:user1).id)

      # verify the user was changed properly
      user.username.must_equal "Minie"
      must_respond_with :redirect
    end

    it "can't update a user with missing parameters" do
      put user_path(users(:user2).id), params: {user: {username: ""} }
      user = User.find(users(:user2).id)
      user.username.wont_equal ""
    end

    it "can delete an existing user" do
      proc { delete user_path(users(:user1).id) }.must_change 'User.count', -1
      must_respond_with :redirect
    end

  end
end
