require "test_helper"

describe SessionsController do
  it "should got to login page" do
    get login_path
    must_respond_with :success
  end

  describe "if a user exists" do
    it "should find the user" do

    end

    it " should pass the user to session and redirect" do

    end
  end

  describe "if the user doesn't exist" do
    it "should render with a bad request status" do

    end

  end
end
