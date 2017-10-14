require "test_helper"

describe WorksController do

  describe "index" do
    it "returns a success status" do
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
    it "returns success when given a valid work ID" do
      valid_id = Work.first.id
      get work_path(valid_id)
      must_respond_with :success
    end

    it "returns not_found when given a bogus work ID" do
      bogus_id = Work.last.id + 1
      get work_path(bogus_id)
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "returns success" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "edit" do
    it "returns success when given a valid work ID" do
      work_id = Work.first.id
      get edit_work_path(work_id)
      must_respond_with :success
    end

    it "returns not_found when given a bogus work ID" do
      invalid_work_id = Work.last.id + 1
      get edit_work_path(invalid_work_id)
      must_respond_with :not_found
    end
  end

  describe "create" do
    it "adds a work to the DB and redirects when the work data is vaild" do
      valid_work_data = {
        work: {
          title: "test book title",
          category: "book"
        }
      }
      start_work_count = Work.count
      Work.new(valid_work_data[:work]).must_be :valid?
      post works_path, params: valid_work_data
      must_respond_with :redirect
      must_redirect_to works_path

       Work.count.must_equal start_work_count + 1
    end

    it "sends bad_request when the work data is bogus" do
      bogus_work_data = {
        work: {
          #no title
          category: "album"
        }
      }

      start_work_count = Work.count
      Work.new(bogus_work_data[:work]).wont_be :valid?
      post works_path, params: bogus_work_data
      must_respond_with :bad_request
      Work.count.must_equal start_work_count
    end
  end

  describe "update" do
    it "returns success if the work ID is valid and the change is valid" do
      work = Work.first
      valid_work_update = {
        work: {
          title: "new album title",
          category: "album"
        }
      }
      work.update_attributes(valid_work_update[:work])
      work.must_be :valid?

      patch work_path(work), params: valid_work_update
      must_respond_with :redirect
      must_redirect_to work_path(work)
      work.reload
      work.title.must_equal valid_work_update[:work][:title]

    end

    it "returns not_found if the work ID is bogus" do
      invalid_work_id = Work.last.id + 1
      valid_work_update = {
        work: {
          title: "new album title",
          category: "album"
        }
      }
      patch work_path(invalid_work_id), params: valid_work_update
      must_respond_with :not_found
    end

    it "returns bad_request if the work ID is valid and the change is bogus" do
      work = Work.first
      bogus_work_update = {
        work: {
          title: "a title",
          category: ""
        }
      }
      work.update_attributes(bogus_work_update[:work])
      work.wont_be :valid?

      patch work_path(work), params: bogus_work_update
      must_respond_with :bad_request

      work.reload
      work.title.wont_equal bogus_work_update[:work][:title]
    end
  end

  describe "destroy" do
    it "returns success and destroys work when given a valid work ID" do
      work_id = Work.first.id
      before_delete = Work.count
      delete work_path(work_id)

      must_respond_with :redirect
      must_redirect_to works_path
      Work.find_by(id: work_id).must_be_nil
      Work.count.must_equal before_delete-1
    end

    it "returns not_found when given an invalid work ID" do
      work_id = Work.first.id + 1
      before_delete = Work.count
      delete work_path(work_id)

      must_respond_with :not_found
      Work.count.must_equal before_delete
    end
  end
end
