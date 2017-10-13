require "test_helper"

describe UsersController do
  let(:user1) { users(:user1) }

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
    it "should get user detail page (#show) or render a 404" do
      #true
      get user_path(user1.id)
      must_respond_with :success

      #false
      get user_path("this is not an id")
      must_respond_with :not_found
    end

  end #

end
