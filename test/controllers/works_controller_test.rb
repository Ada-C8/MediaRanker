require "test_helper"

describe WorksController do
  describe "index" do
    it "returns success for all works" do
      get works_path
      must_respond_with :success
    end
  end

  describe "new" do
    it "returns success for a new work" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "adds work to the database and redirects when the work data is valid" do
      work_data = {
        work: {
          title: "testing",
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

    it "re-renders form when the work data is invalid" do
      work_data = {
        work: {
          category: "album"
        }
      }
      Work.new(work_data[:work]).wont_be :valid?
      start_work_count = Work.count

      post works_path, params: work_data

      must_respond_with :bad_request
      Work.count.must_equal start_work_count
    end
  end

  describe "show" do
    it "returns success with valid id" do
      work_id = Work.first.id
      get work_path(work_id)
      must_respond_with :success
    end

    it "returns not_found with invalid id" do
      invalid_id = Work.last.id + 1
      get work_path(invalid_id)
      must_respond_with :not_found
    end
  end

  describe "edit" do
    it "returns success with valid id" do
      work_id = Work.first.id
      get edit_work_path(work_id)
      must_respond_with :success
    end

    it "returns not_found with invalid id" do
      invalid_id = Work.last.id + 1
      get edit_work_path(invalid_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "returns success if work exists and changes are valid" do
      work = Work.first
      changes = {
        work: {
          title: "testing",
          category: "movie"
        }
      }
      work.update_attributes(changes[:work])
      work.must_be :valid?

      patch work_path(work), params: changes
      must_respond_with :redirect
      must_redirect_to work_path(work)

      work.reload
      work.title.must_equal changes[:work][:title]
    end

    it "returns bad_request if work exists and changes are invalid" do
      work = Work.first
      changes = {
        work: {
          title: "",
        }
      }
      work.update_attributes(changes[:work])
      work.wont_be :valid?

      patch work_path(work), params: changes
      must_respond_with :bad_request
    end

    it "returns not_found if work does not exist" do
      work = Work.first
      changes = {
        work: {
          title: "testing",
          category: "movie"
        }
      }
      work.update_attributes(changes[:work])
      work.must_be :valid?
      work.destroy

      patch work_path(work), params: changes
      must_respond_with :not_found
    end
  end

  describe "destroy" do
    it "returns success and destroys if work exists" do
      work = Work.first
      work.must_be :valid?
      delete work_path(work)
      must_respond_with :redirect
      must_redirect_to works_path
    end

    it "returns not_found if work does not exist" do
      work = Work.first
      work.must_be :valid?
      delete work_path(work)
      delete work_path(work)
      must_respond_with :not_found
    end
  end
end
