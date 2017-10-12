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

  describe "new" do
    it "returns success" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "redirects to works_path if the work data is valid and adds a work to the db" do
      # # Arrange
      work_data = {
        work: {
          category: "movie",
          title: "Shawshank Redemption"
        }
      }
      # test if work is valid
      Work.new(work_data[:work]).must_be :valid?

      # # Act
      post works_path, params: work_data

      # # Assert
      must_respond_with :redirect
      must_redirect_to works_path
    end

    it "returns bad_request status when the work data is invalid" do
      # # Arrange
      # # Act
      # # Assert
    end
  end
#
#   describe "show" do
#     it "returns success when given a valid work_id and user has votes" do
#       # # Arrange
#       # # Act
#       # # Assert
#     end
#
#     it "returns success when given a valud work_id and user has no votes" do
#
#     end
#     it "returns not_found when given an invalid work_id" do
#       # # Arrange
#       # # Act
#       # # Assert
#     end
#
#   end
#
#   describe "edit" do
#
#   end
#
#   describe "update" do
#
#   end
#
#   describe "destroy" do
#
#   end
end
