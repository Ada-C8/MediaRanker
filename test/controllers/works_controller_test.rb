require "test_helper"

describe WorksController do
  describe "index" do
    it "returns a success status for all works" do
      get works_path
      must_respond_with :success
    end

    it "returns a success status for no works" do
      Work.destroy_all
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
        #no category given
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

  describe "edit" do
    it "returns success when given a valid work ID" do
      valid_work_id = Work.first.id
      get edit_work_path(valid_work_id)
      must_respond_with :success
    end

    it "returns not_found when given a invalid work ID" do
      invalid_work_id = Work.last.id + 1
      get edit_work_path(invalid_work_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "returns success when found work and updated it" do
      work = Work.first
      valid_work_data = {
        work: {
          category: "book",
          title: "Another Book"
        }
      }
      work.update_attributes(valid_work_data[:work])
      work.must_be :valid?

      patch work_path(work), params: valid_work_data

      must_respond_with :redirect
      must_redirect_to work_path(work)

      work.reload
      work.title.must_equal valid_work_data[:work][:title]
    end

    it "returns not_found when the work ID is invalid" do
      invalid_work_id = Work.last.id + 1
      valid_work_data = {
        work: {
          category: "book",
          title: "Another Book"
        }
      }
      patch work_path(invalid_work_id), params: valid_work_data

      must_respond_with :not_found
    end

    it "returns bad_request if the data is invalid" do
      work = Work.first
      invalid_work_data = {
        work: {
          category: "",
          title: "hello"
        }
      }
      work.update_attributes(invalid_work_data[:work])
      work.wont_be :valid?

      patch work_path(work), params: invalid_work_data

      must_respond_with :bad_request

      work.reload
      work.title.wont_equal invalid_work_data[:work][:title]
    end
  end

  describe "destroy" do
    it "returns success and destroys the work when given a valid work ID" do
      valid_work_id = Work.first.id
      start_count = Work.count

      delete work_path(valid_work_id)

      must_respond_with :redirect
      must_redirect_to works_path
      Work.count.must_equal start_count - 1
      Work.find_by(id: valid_work_id).must_be_nil
    end

    it "returns not_found when given a invalid work ID" do
      invalid_work_id = Work.last.id + 1
      start_count = Work.count

      delete work_path(invalid_work_id)

      must_respond_with :not_found
      Work.count.must_equal start_count
    end
  end
end
