require "test_helper"

describe UsersController do

  it "successfully loads works index page to list all works" do
    get users_path
    must_respond_with :success
  end

  it "successfully loads an individual users' voting summary (#show)page" do
    get user_path( users(:jane).id )
    must_respond_with :success   
  end



end
