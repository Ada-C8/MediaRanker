require "test_helper"

describe SessionsController do
  it "should got to login page" do
    get login_path
    must_respond_with :success
  end

end
