require "test_helper"

describe MainPageController do
  it "should get index" do
    get root_path
    value(response).must_be :success?
  end

end
