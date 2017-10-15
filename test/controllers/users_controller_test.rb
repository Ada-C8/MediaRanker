require "test_helper"

describe "UsersController" do

  it "can successfully go to the works index page" do
    get users_path
    must_respond_with :success
  end

  it "should be able to visit an individual user show page" do
    get user_path( users(:fanGirl).id )
    must_respond_with :success
  end

  it "if try to show for user that doesn't exist does 404 error" do
    get work_path(-2)
    must_respond_with :not_found
  end

end
