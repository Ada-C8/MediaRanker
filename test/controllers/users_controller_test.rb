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
      get user_path(id)
      must_respond_with :not_found
    end # not_found
  end # show

end # UsersController
