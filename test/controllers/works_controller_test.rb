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

#   describe "new" do
#     # didn't do this in lecture figure it out
#   end
#
#   describe "create" do
#     it "redirects to works_path if the work data is valid" do
#       # # Arrange
#       # # Act
#       # # Assert
#     end
#
#     it "returns bad_request status when the work data is invalid" do
#       # # Arrange
#       # # Act
#       # # Assert
#     end
#   end
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
