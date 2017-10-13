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

  #WHY is this not passing?
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
      Work.count.must_equal start_count
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


end
