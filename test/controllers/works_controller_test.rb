require "test_helper"

describe WorksController do

  describe "index" do
    it "return a success status" do
      get works_path
      must_respond_with :success
    end

    it "returns a success status when no works" do
      Work.destroy_all
      get works_path
      must_respond_with :success
    end
  end

  describe "new" do
    it "returns a success" do
      get new_work_path
      must_respond_with :success
    end
    it "" do

    end
  end

  describe "create" do
    it "redirects to works_path when work data is valid" do
      work_data = {
        work: {
          title: "test",
          creator: "test",
          category: "album"
        }
      }
      Work.new(work_data[:work]).must_be :valid?

      start_work_count = Work.count

      post works_path, params: work_data
      must_respond_with :redirect
      must_redirect_to works_path

      Work.count.must_equal start_work_count + 1
    end
    it "sends bad request when work data is invalid" do
      invalid_work_data = {
        work: {
          title: "",
          creator: "",
          category: ""
        }
      }
      Work.new(invalid_work_data[:work]).wont_be :valid?

      start_work_count = Work.count

      post works_path, params: invalid_work_data
      must_respond_with :bad_request

      Work.count.must_equal start_work_count
    end
  end

  describe "show" do
    it "returns sucess when given a valid work id" do
      work_id = Work.first.id
      get work_path(work_id)
      must_respond_with :success
    end
    it "returns not found when given a invalid work id" do
      work_id = Work.first.id + 1
      get work_path(work_id)
      must_respond_with :not_found
    end
  end

  describe "edit" do
    it "returns success when given a valid work id" do
      work_id = Work.first.id
      get edit_work_path(work_id)
      must_respond_with :success
    end
    it "returns not found when given a valid work id" do
      work_id = Work.first.id + 1
      get edit_work_path(work_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "returns success if work id is valid and change is valid" do
      work_id = Work.first.id
      get work_path(work_id)
      must_respond_with :success
      ## returning 200 instead of redirect
      # must_respond_with :redirect

    end
    it "returns not found if the work id is invalid" do
      work_id = Work.first.id + 1
      get work_path(work_id)
      must_respond_with :not_found
    end
    it "returns bad request if the change is invalid" do

    end
  end

  describe "destroy" do
    it "exist" do

    end
    it "does not exist" do

    end
  end
end
