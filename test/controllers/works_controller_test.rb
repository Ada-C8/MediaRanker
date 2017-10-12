require "test_helper"

describe WorksController do
  describe "index" do
    it "will return success status" do
      get works_path
      must_respond_with :success
    end # it "will return success status" do
  end # index
end
