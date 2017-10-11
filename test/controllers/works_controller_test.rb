require "test_helper"

describe WorksController do

  describe "index" do
    it "returns a success status for all books" do
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
    it "returns success when given a valid work id" do
      # Arrange
      work_id = Work.first.id

      # Act
      get work_path(work_id)

      # Assert
      must_respond_with :success

    end

    it "returns not_found when given an invalid work id" do
      # Arrange
      invalid_work_id = Work.last.id + 1

      # Act
      get work_path(invalid_work_id)

      # Assert
      must_respond_with :not_found

    end

  end

  describe "edit" do
    it "returns success when given a valid work id" do
      # Arrange
      work_id = Work.first.id

      # Act
      get edit_work_path(work_id)

      # Assert
      must_respond_with :success

    end

    it "returns not_found when given an invalid work id" do
      # Arrange
      work_id = Work.last.id + 1

      # Act
      get edit_work_path(work_id)

      # Assert
      must_respond_with :not_found

    end

  end


  describe "new" do
    it "renders new page" do

    end

  end

  describe "create" do
    it "redirects to show page when the book data is valid" do
      #Arrange
      work_data = {
        work: {
          category: "album",
          title: "Test book"
        }
      }

      # makes sure test breaks if we change the model (i.e., test data no longer vaild)
      Work.new(work_data[:work]).must_be :valid?
      test_work = Work.create!(work_data[:work])

      #Act
      # post works_path, params: work_data
      post works_path, params: work_data


      start_work_count = Work.count

      #Assert

      must_respond_with :redirect
      must_redirect_to work_path(test_work.id)

      Work.count.must_equal start_work_count + 1
    end

    it "sends bad_request when the new page when the work data is bogus" do
      # don't pass in valid info
      # i.e. a required field like title
      # should render new
      #Arrange
      invalid_work_data = {
        work: {
          category: "album",
          # title: "Test book"
        }
      }

      # makes sure test breaks if we change the model (i.e., test data no longer vaild)
      Work.new(invalid_work_data[:work]).wont_be :valid?

      #Act
      post works_path, params: invalid_work_data

      start_work_count = Work.count

      #Assert
      must_respond_with :bad_request
      # must_redirect_to new_work_path

      Work.count.must_equal start_work_count


    end

  end

  describe "update" do

    it "returns success if the work exists and the change is valid" do

    end

    it "returns not_found if the work id is not valid" do

    end

    it "returns bad request if the changes are not valid" do

    end

  end

  describe "destroy" do
    it "returns success if the book id is valid" do

    end

    it "returns not found if the book id is not valid" do

    end

  end
end
