require "test_helper"

describe WorksController do
  describe "index" do
    it "returns a success status for all works" do
      get works_path
      must_respond_with :success
    end

    it "returns a success status for no works" do
      get works_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "returns success when given a valid work ID" do
      valid_work_id = Work.first.id
      get work_path(valid_work_id)
      must_respond_with :success
    end

    it "returns not_found when given a invalid work ID" do
      invalid_work_id = Work.last.id + 1
      get work_path(invalid_work_id)
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "returns success" do
      get new_work_path do
        must_respond_with :success
      end
    end
  end

  describe "create" do
    it "adds new work to the DB and redirects when the work data is valid" do
      new_work_data = {
        work: {
          category: "album",
          title: "New title"
        }
      }
      Work.new(new_work_data[:work]).must_be :valid?

      start_count = Work.count

      post works_path, params: new_work_data

      must_respond_with :redirect
      Work.count.must_equal start_count + 1
    end

    it "sends bad_request when the new work is invalid" do
      invalid_new_work_data = {
        #no category
        work: {
          title: "hello"
        }
      }
      Work.new(invalid_new_work_data[:work]).wont_be :valid?

      start_count = Work.count

      post works_path, params: invalid_new_work_data

      must_respond_with :bad_request
      Work.count.must_equal start_count
    end
  end
end
