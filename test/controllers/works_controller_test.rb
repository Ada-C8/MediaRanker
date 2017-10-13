require "test_helper"

describe WorksController do
  let :work_data {
    work_data = {
      work: {
        title: "GhostBusters",
        category: "movie"
      }
    }
  }
  let :bad_work_data {
    bad_work_data = {
      work: {
        title: "",
        category: "movie"
      }
    }
  }
  let :work_id { Work.last.id }
  # use let to create refernce variables here
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

  describe "new" do
    it "returns success" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "redirects to works_path if the work data is valid and adds a work to the db" do
      # # Arrange
      # test if work is valid
      Work.new(work_data[:work]).must_be :valid?
      work_count = Work.count
      # # Act
      post works_path, params: work_data
      # # Assert
      must_respond_with :redirect
      must_redirect_to works_path
      Work.count.must_equal work_count + 1
    end

    it "returns bad_request status when the work data is invalid" do
      # # Arrange
      # test that work is invalid
      Work.new(bad_work_data[:work]).wont_be :valid?
      work_count = Work.count
      # # Act
      post works_path, params: bad_work_data
      # # Assert
      must_respond_with :bad_request
      Work.count.must_equal work_count
    end
  end

  describe "show" do
    it "returns success when given a valid work ID" do
      # # Arrange
      # # Act
      get work_path(work_id)
      # # Assert
      must_respond_with :success
    end

    it "returns not_found when given an invalid work_id" do
      # # Arrange
      # # Act
      get work_path(work_id + 1)
      # # Assert
      must_respond_with :not_found
    end

  end

  describe "edit" do
    it "returns success when given a valid work ID" do
      # # Arrange
      # # Act
      get edit_work_path(work_id)
      # # Assert
      must_respond_with :success
    end

    it "returns not_found when given a invalud work ID" do
      # # Arrange
      # # Act
      get edit_work_path(work_id + 1)
      # # Assert
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "returns success if the work ID is valid and the change is valid" do
      # # Arrange
      work = Work.first
      work_data = {
        work: {
          category: work.category,
          title: "updated title"
        }
      }
      work.update_attributes(work_data[:work])
      work.must_be :valid?

      # # Act
      patch work_path(work), params: work_data

      # # Assert
      must_respond_with :redirect
      must_redirect_to work_path(work)
      # check that the change went through
      work.reload
      work.title.must_equal work_data[:work][:title]
    end

    it "returns bad_request if the change is invalid, no title" do
      # # Arrange
      work = Work.first
      work.update_attributes(bad_work_data[:work])
      work.wont_be :valid?

      # # Act
      patch work_path(work), params: bad_work_data

      # # Assert
      must_respond_with :bad_request
      work.reload
      work.title.wont_equal bad_work_data[:work][:title]
    end

    it "returns not_found if the book ID is invalid" do
      # # Arrange
      # # Act
      get edit_work_path(work_id + 1)
      # # Assert
      must_respond_with :not_found
    end
  end

  describe "destroy" do
    it "returns success, and destroys the work, if the work ID is valid " do
      # # Arrange
      work_count = Work.count
      # # Act
      delete work_path(work_id)
      # # Assert
      must_respond_with :redirect
      must_redirect_to works_path
      # check work was destroyed
      Work.find_by(id: work_id).must_be_nil
      Work.count.must_equal work_count - 1
    end

    it "returns not_found if the work ID is invalid" do
      # # Arrange
      work_count = Work.count
      # # Act
      delete work_path(work_id + 1)
      # # Assert
      must_respond_with :not_found
      # check book wasn't destroyed
      Work.count.must_equal work_count
    end
  end
end
