require "test_helper"
describe MainController do
  describe "index" do
    it "can successfully show works" do
      get works_path
      must_respond_with :success
    end
    it "returns a success status when there are no works" do
      Work.destroy_all
      get works_path
      must_respond_with :success
    end
  end
end
