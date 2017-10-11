require "test_helper"

describe "WorksController" do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe "index" do
    it "returns a success status for all works" do
      get works_path
      must_respond_with :success
    end
  end

end
