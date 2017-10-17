require "test_helper"

describe WorksController do
  describe "index" do
    it "returns a success status" do
      get works_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "returns a success status when an existing work is selected" do
      get work_path(Work.first)
      must_respond_with :success
    end

    it "returns an error message when given a bogus work id" do
      get work_path(Work.last.id + 1)
      must_respond_with :not_found
    end

    it "returns a success status when there are no works" do
      Work.destroy_all
      get works_path
      must_respond_with :success
    end
  end

#failing to add the book to the database, why?  Think I don't understand the test well rather than method not working.
  describe "create" do
    it "adds the Work to the database when data given is valid and redirects to Work#Index once done" do
      start_count = Work.all.count
      work_data = {
        work: {
          title: "this is a test",
          category: "album",
          creator: "Nobody"
        }
      }
      Work.new(work_data[:work]).must_be :valid?


      post works_path, params: work_data
      must_respond_with :redirect
      must_redirect_to works_path
      Work.count.must_equal (start_count + 1)
    end

    it "if data given is invalid, it will render a new form and will not add the Work to the database" do
      start_count = Work.all.count
      invalid_work_data = {
        work: {
          #NO TITLE
          category: "album"
        }
      }
      Work.new(invalid_work_data[:work]).wont_be :valid?
      post works_path, params: invalid_work_data
      must_respond_with :bad_request

      start_count.must_equal Work.all.count
    end
  end

  describe "new" do
    it "returns a success status" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "edit" do
    it "returns a success status when given a valid Work id" do
      work = works(:cat_stevens)
      get work_path(work)
      must_respond_with :success
    end

    it "returns an error message when given a bogus work id" do
      get work_path(Work.last.id + 1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "returns success if Work exists, change is valid, and db updated" do
      work = Work.first

      work_data = {
        work: {
          title: work.title,
          category: work.category,
          description: "changed description"
        }
      }

      work.update_attributes(work_data[:work])
      work.must_be :valid?, "Test is invalid because the provided data will produce an invalid work."

      patch work_path(work), params: work_data
      must_respond_with :redirect
      must_redirect_to work_path(work)

      #Check that the change went through
      work.reload
      work.title.must_equal work_data[:work][:title]
    end

    it "returns not_found if the work ID is invalid" do
      invalid_work_id = Work.last.id + 1
      work_data = {
        work: {
          title: "Title",
          category: "book",
          description: "changed description"
        }
      }
      patch work_path(invalid_work_id), params: work_data
      must_respond_with :not_found
    end

    it "returns bad_request if the change is invalid" do
      work = Work.first
      invalid_work_data = {
        work: {
          title: "",
          category: "album"
        }
      }
   # Check that the update is actually invalid
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
      work_id = Work.first.id

      delete work_path(work_id)

      must_respond_with :redirect
      must_redirect_to works_path
      Work.find_by(id: work_id).must_be_nil
    end

    it "returns not_found when given an invalid Work ID" do
      invalid_work_id = Work.last.id + 1

      start_work_count = Work.count

      delete work_path(invalid_work_id)

      must_respond_with :not_found
      Work.count.must_equal start_work_count
    end
  end

end
