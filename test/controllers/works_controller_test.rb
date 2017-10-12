require "test_helper"

describe WorksController do

  describe "index" do
    it "returns a success status" do
      get works_path
      must_respond_with :success
    end

    it "returns a success status when there are no books" do
      Work.destroy_all
      get works_path
      must_respond_with :success
    end

    it "returns a success when given a vaild author" do
      valid_id = Work.first.id
      get works_path(valid_id)
      must_respond_with :success
    end

    # Why this no work?
    it "returns not_found when given a bogus author" do
      bogus_id = Work.last.id + 1
      get works_path(bogus_id)
      must_respond_with :not_found
    end
  end


  describe "show" do
    it "returns success when given a valid book ID" do
      valid_id = Work.first.id
      get work_path(valid_id)
      must_respond_with :success
    end

    it "returns success when given a bogus book ID" do
      bogus_id = Work.last.id + 1
      get work_path(bogus_id)
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "works with an author id" do
      valid_id = Work.last.id + 1
      get new_work_path(valid_id)
      must_respond_with :success
    end

    it "works without an author id" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "edit" do
    it "returns success when given a valid work ID" do
      work_id = Work.first.id
      get edit_work_path(work_id)
      must_respond_with :success
    end

    it "returns not_found when given an invalid work ID" do
      invalid_work_id = Work.last.id + 1
      get edit_work_path(invalid_work_id)
      must_respond_with :not_found
    end
  end


  describe "create" do
  end

  describe "update" do
    it "returns success if the book ID is valid..." do

    end

  end

  describe "destroy" do
    it "returns success and destroys the work when given a valid work ID" do
      work_id = Work.first.id
      delete work_path(work_id)
      before_delete = Work.count

      must_respond_with :redirect
      must_redirect_to works_path
      Work.find_by(id: work_id).must_be_nil
      Work.count.must_equal before_delete-1
    end

    it "returns not_found when given an invalid work ID" do
      work_id = Work.first.id + 1
      delete work_path(work_id)
      before_delete = Work.count

      must_respond_with :not_found
      Work.count.must_equal before_delete
    end
  end
end
