require "test_helper"

describe WorksController do
  describe "index" do
    it "returns a success status for all works" do
      get works_path
      must_respond_with :success
    end

    it "returns a success status when there are no works" do
      Work.destroy_all
      get works_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "returns a success if work exists" do
      get work_path(Work.first)
      must_respond_with :success
    end

    it "should return a Not Found Error (or 404) if work isn't found" do
      get work_path(Work.last.id + 1)
      must_respond_with :not_found
    end
  end

end
