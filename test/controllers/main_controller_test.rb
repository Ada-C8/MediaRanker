require "test_helper"

describe MainController do
  describe "index" do
    # check that the index page works
    it "returns success status" do
      # act
      get root_path
      # assert
      must_respond_with :success
    end
  end # index
end
