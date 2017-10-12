require "test_helper"

describe HomeController do
  it "should get index" do
    get home_index_path
    must_respond_with :success
  end

end
