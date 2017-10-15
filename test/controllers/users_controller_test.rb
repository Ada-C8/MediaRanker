require "test_helper"

describe UsersController do
  describe "index" do
    it "returns a success status" do
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "returns a success status when an existing user is selected" do
      get users_path(User.first.id)
      must_respond_with :success
    end

    it "returns an error message when given a bogus User id" do
      get users_path(User.last.id + 1)
      must_respond_with :not_found
    end

    it "returns a success status when there are no users" do
      User.destroy_all
      get users_path
      must_respond_with :success
    end
  end

  #THis test won't work... doesn't recognize login as a method?!
  # describe "login" do
  #   u = User.create!(name: "someone")
  #   user_data = {
  #     user: {
  #       name: u.name
  #     }
  #   }
  #   login
  #
  #   must_redirect_to root_path
  #   must_respond_with :success
  # end
end
