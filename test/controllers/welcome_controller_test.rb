require "test_helper"

describe "WelcomeController" do
  it "should go to the index page" do
    get root_path
    must_respond_with :success
  end

end
