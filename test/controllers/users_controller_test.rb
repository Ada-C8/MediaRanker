require "test_helper"

describe UsersController do


  describe "CRUD methods" do
    it "should get index" do
      get users_path
      must_respond_with :success
    end

    it "should display a form for a new User" do
      get new_user_path
      must_respond_with :success
    end

    it "should create a new User" do
      #false - invalid (without username)
      proc { post users_path, params: { user: { username: nil } } }.must_change 'User.count', 0
      must_respond_with :success #renders

      #true
      proc { post users_path, params: { user: { username: "A Name" } } }.must_change 'User.count', 1
      must_respond_with :redirect
    end
    # it "should get edit" do
    #   get users_edit_url
    #   value(response).must_be :success?
    # end
    #
    # it "should get show" do
    #   get users_show_url
    #   value(response).must_be :success?
    # end

  end #

end
