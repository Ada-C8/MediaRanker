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

  describe "new" do
    it "returns a success" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "will successfully create work item" do
      work_data = {
        work: {
          title: "Test book",
          category: "album"
        }
      }
      work_count = Work.count
      post works_path, params: work_data

      must_respond_with :redirect
      must_redirect_to works_path

      Work.count.must_equal work_count + 1
    end

    it "will successfully create work item" do
      bad_work_data = {
        work: {
          #No title,
          category: "album"
        }
      }
      work_count = Work.count
      post works_path, params: bad_work_data

      must_respond_with :bad_request

      Work.count.must_equal work_count
    end
  end
end
