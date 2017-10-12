require "test_helper"

describe UsersController do
  it "can successfully load an index page" do
    get users_path
    must_respond_with :success
  end


end
