require "test_helper"

describe UsersController do

  describe "index" do
    it "shows all users" do
      get users_path
      must_respond_with :success
    end

    it "does not error even if there are zero users" do
      Work.destroy_all
      get users_path
      must_respond_with :success
    end
  end

  describe "login" do
  end

  describe "login_form " do
  end

  describe "show" do
  end

  describe "new" do
  end

  describe "create" do
  end


end
