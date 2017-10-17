require "test_helper"

describe MainController do
  describe "index" do
    it "should get index" do
      get root_path
      must_respond_with :success
    end
    it "returns a success status when no records" do
      skip
      Work.destroy_all
      get root_path
      must_respond_with :success
    end
  end
end
