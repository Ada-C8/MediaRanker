require "test_helper"

describe WorksController do
  describe "index" do
    it "will return success status" do
      get works_path
      must_respond_with :success
    end # it "will return success status" do
  end # index

  describe "new" do
    it "will return a success status" do
      get new_work_path
      must_respond_with :success
    end #it "will return a success status" do
  end # describe "new" do

  describe "create" do
    it "adds the work to the DB and then redirects to the works_path when work data is valid" do
      # Arrange
      work_data = {
        work: {
          category: "book",
          title: "HP 3",
          creator: "J.K Rowling"
        }
      }
      new_work = Work.new(work_data[:work]).must_be :valid?

      start_count_work = Work.count

      # Act
      post works_path, params: work_data

      # Assert
      must_respond_with :redirect
      must_redirect_to works_path

      Work.count.must_equal start_count_work + 1
    end # "it adds the work..."

    xit "returns bad_request when the work data is invalid" do
      # QUESTION: what is invalid data? add this test if we add validations to the Work model
    end # it "returns bad_request when the work data is invalid" do
  end #describe "create" do

  describe "show" do
    it "returns success when given a valid work id" do
      id = Work.first.id
      get work_path(id)
      must_respond_with :success
    end # it "returns success ... valid work id" do

    it "returns not_found when given an invalid work id" do
      invalid_id = Work.last.id + 1
      get work_path(invalid_id)
      must_respond_with :not_found
    end # it "returns not_found ... invalid work id" do
  end #describe "show" do

end
