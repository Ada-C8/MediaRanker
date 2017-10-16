require "test_helper"

describe MainController do
  describe "index" do
    it "gets index and returns a success status for all works" do
      get root_path
      must_respond_with :success
    end

    it "returns a success status when there are no works" do
      Work.destroy_all
      get root_path
      must_respond_with :success
    end
  end
end
