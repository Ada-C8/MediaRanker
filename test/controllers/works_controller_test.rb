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

    it "returns bad_request when the work data is invalid" do
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

  describe "edit" do
    it "return success when given a valid work id" do
      work_id = Work.first.id
      get edit_work_path(work_id)
      must_respond_with :success
    end # it "return success when given a valid work id" do

    it "returns not_found when given an invalid work id" do
      invalid_work_id = Work.last.id + 1
      get edit_work_path(invalid_work_id)
      must_respond_with :not_found
    end # it "returns not_found when given an invalid work id" do
  end # describe "edit" do

  describe "update" do
    it "will return success if the work id is valid and given valid work data" do
      # arrange
      work = Work.first
      work_data = {
        work: {
          category: "book",
          title: "HP 3",
          creator: "J.K Rowling"
        }
      }
      work.update_attributes(work_data[:work])
      work.must_be :valid?

      # act
      patch work_path(work), params: work_data

      # Assert
      must_respond_with :redirect
      must_redirect_to work_path(work)

    end # success

    it "will return not_found if the work id is invalid" do
      # Arrange
      invalid_id = Work.last.id + 1
      work_data = {
        work: {
          category: "book",
          title: "HP 3",
          creator: "J.K Rowling"
        }
      }

      # act
      patch work_path(invalid_id), params: work_data

      # Assert
      must_respond_with :not_found
    end # invalid work id

    it "will respond with bad_request if the change is invalid" do
      # TODO: Add this test if we add any validations to the work model
    end
  end # describe "update" do

  describe "destroy" do
    it "redirects and destroys the work when given a valid work id" do
      work_id = Work.first.id
      work_count = Work.count

      delete work_path(work_id)
      must_respond_with :redirect
      must_redirect_to works_path
      Work.find_by(id: work_id).must_be_nil
    end # return success

    it "returns not_found when given an invalid work id" do
      invalid_work_id = Work.last.id + 1
      start_work_count = Work.count

      delete work_path(invalid_work_id)

      must_respond_with :not_found
      Work.count.must_equal start_work_count
    end # returns invalid
  end # describe "destroy" do

end
