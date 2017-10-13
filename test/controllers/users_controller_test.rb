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
