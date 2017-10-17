require "test_helper"

describe WorksController do

  describe "index " do
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

  describe "new" do
    # esto es lo que estoy probando aca?
    it "can show the new form" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "adds new work to the data base and redirect to the all work page when data is valid" do
      # Arrange
      work_data = {
        work: {
          title: "work to try",
          category: "album"
        }
      }
      # Test data should result in a valid work, otherwise
      # the test is broken
      Work.new(work_data[:work]).must_be :valid?

      start_work_count = Work.count

      # Act
      #?????Que esta haciendo esta linea??????
      post works_path, params: work_data

      # Assert
      must_respond_with :redirect
      must_redirect_to works_path

      Work.count.must_equal start_work_count + 1
    end

    it "sends bad_request when the work data is bogus" do
      # Arrange
      invalid_work_data = {
        work: {
          title: "new new",
          category:"algo mas"

        }
      }
      # Double check the data is truly invalid
      Work.new(invalid_work_data[:work]).wont_be :valid?

      start_work_count = Work.count

      # Act
      post works_path, params: invalid_work_data

      # Assert
      must_respond_with :bad_request
      Work.count.must_equal start_work_count
    end
  end

  describe "show"  do
    it "returns success when given a valid work ID" do
      # Arrange
      work_id = Work.first.id

      # Act
      get work_path(work_id)

      # Assert
      must_respond_with :success
    end

    # it "returns not_found when given an invalid work ID" do
    #   invalid_work_id = Work.last.id + 1
    #   get work_path(invalid_work_id)
    #   must_respond_with :not_found
    # end
  end
end#big describe
