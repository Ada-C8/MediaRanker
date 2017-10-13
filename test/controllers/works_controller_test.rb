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

    it "will not create work item if model is invalid" do
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

  describe "edit" do
    it "returns a success if work exists" do
      get edit_work_path(Work.first)
      must_respond_with :success
    end

    it "should return a Not Found Error (or 404) if work isn't found" do
      get edit_work_path(Work.last.id + 1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "will successfully update work item" do
      w = Work.first
      work_data = {
        id: w.id,
        work: {
          title: w.title + "New Title"
        }
      }

      patch work_path(w), params: work_data

      must_respond_with :redirect
      must_redirect_to work_path(w)

      Work.find(w.id).title.must_equal w.title + "New Title"
    end

    it "will return not found, if item doesn't exist" do
      bad_id = Work.last.id + 1
      work_data = {
        id: bad_id,
        work: {
          title: "New Title"
        }
      }

      patch work_path(bad_id), params: work_data

      must_respond_with :not_found
    end

    it "will not let you invalidate work item" do
      w = Work.first
      work_data = {
        id: w.id,
        work: {
          title: "" # Clearing the title
        }
      }

      patch work_path(w), params: work_data

      must_respond_with :bad_request

      Work.find(w.id).title.must_equal w.title
    end
  end

  describe "destroy" do
    it "returns success and destroys the work when given a valid work ID" do
      w_id = Work.first.id # Arrange

      delete work_path(w_id) # Act

      must_respond_with :redirect # Assert
      must_redirect_to works_path

      Work.find_by(id: w_id).must_be_nil
    end

    it "should return not found when given invalid work ID" do
      bad_w_id = Work.last.id + 1 # Arrange
      work_count = Work.count

      delete work_path(bad_w_id) #Act

      must_respond_with :not_found # Assert
      Work.count.must_equal work_count
    end
  end
end
