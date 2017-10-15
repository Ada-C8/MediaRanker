require "test_helper"

describe WorksController do

  describe "#index" do
    it "returns success if all Works are valid" do
      start_work_count = Work.count
      get works_path

      must_respond_with :success
      start_work_count.must_equal Work.count
    end

    it "returns a success status when there are no works" do
      Work.destroy_all
      get works_path

      must_respond_with :success
      Work.count.must_equal 0
    end
  end # Describe

  describe "#show" do
    # The ID corresponds to a model in the DB
    # The ID is not found in the DB
    it "returns success when the work_id exists" do
      work = Work.first

      work.must_be :valid?
      get work_path(work)

      must_respond_with :success
    end

    it "returns not found when the work_id does not exist" do
      bad_work_id = Work.last.id + 1

      get work_path(bad_work_id)

      must_respond_with :not_found
    end
  end # Des

  describe "#new" do
    # The data was valid
    # The data was bad and validations failed
    it "returns success when accessing the new Work form" do
      get new_work_path

      must_respond_with :success
    end
  end

  describe "#create" do
    it "returns success when all parameters are created and data is valid" do
      # Arrange
      work_data = {
        work: {
          category: "book",
          title: "Harry Potter",
          creator: "J.K. Rowling",
          publication_year: 2001,
          description: "A boy to has a scar",
        }
      }
                # Variable[:hash]
      Work.new(work_data[:work]).must_be :valid?
      start_work_count = Work.count

      # Act
      post works_path, params: work_data

      # Assert
      must_respond_with :redirect
      must_redirect_to works_path
      Work.count.must_equal start_work_count + 1
    end

    it "returns a bad_request if one parameter is invalid" do
      # Arrange
      invalid_data = {
        work: {
          category: "book",
          title: "",
          creator: "J.K. Rowling",
          publication_year: 2001,
          description: "A boy to has a scar",
        }
      }

      Work.new(invalid_data[:work]).wont_be :valid?
      start_work_count = Work.count

      post works_path, params: invalid_data

      # Assert
      must_respond_with :bad_request
      Work.count.must_equal start_work_count
    end
  end # Des

  describe "#edit" do
    it "returns success if the work_id exists" do
      work = Work.first

      work.must_be :valid?

      get work_path(work.id)

      must_respond_with :success
    end

    it "returns not_found if the work_id does not exists" do
      work_id = Work.last.id + 1

      get work_path(work_id)

      must_respond_with :not_found
    end
  end

  describe "#update" do
    it "returns not found when the Work does not exist" do
      work_id = Work.last.id + 1

      patch work_path(work_id)

      must_respond_with :not_found
    end

    it "returns success if the change is valid" do
      work = Work.first

      work_data = {
        work: {
          category: "book",
          title: "I AM CHANGING THE TITLE OF THE THIS BOOK",
          creator: "J.K. Rowling",
          publication_year: 2001,
          description: "A boy to has a scar",
        }
      }

      work.must_be :valid?

      patch work_path(work), params: work_data

      must_respond_with :redirect
      must_redirect_to work_path(work)

      work.reload
      work.title.must_equal work_data[:work][:title]
    end

    it "returns bad_request if the change is invalid" do
      before_count = Work.count
      work = Work.first

      work.must_be :valid?

      invalid_work_data = {
        work: {
          category: "book",
          title: "",
          creator: "J.K. Rowling",
          publication_year: 2001,
          description: "A boy who has a scar",
        }
      }

      patch work_path(work.id), params: invalid_work_data

      must_respond_with :bad_request
      # Check if change went through
      work.reload
      work.title.wont_equal invalid_work_data[:work][:title]
      Work.count.must_equal before_count
    end
  end # Des

  describe "#destroy" do
    it "returns success when given a valid work ID" do
      before_count = Work.count
      work_id = Work.first.id

      delete work_path(work_id)

      must_respond_with :redirect
      must_redirect_to works_path
      Work.find_by(id: work_id).must_equal nil
      Work.count.must_equal before_count - 1
    end

    it "returns not found when a given work ID does not exist" do
      invalid_work_id = Work.last.id + 1

      delete work_path(invalid_work_id)

      must_respond_with :not_found
    end
  end # Des
  
end # Des
