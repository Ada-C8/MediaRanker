require "test_helper"

describe HomepageController do
  it "renders the homepage with get root_path" do
    get root_path
    must_respond_with :success
  end
end
