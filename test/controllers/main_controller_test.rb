require "test_helper"

describe MainController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
  describe "index" do
    it "always returns a success status" do
      get root_path
      must_respond_with :success
    end
  end

end
