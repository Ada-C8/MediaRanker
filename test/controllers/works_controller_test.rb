require "test_helper"

describe WorksController do
  describe "index" do
    it "returns a success status for all works" do
      get works_path
      must_respond_with :success
    end

    it "returns a success status for no works" do
      get works_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "returns success when given a valid work ID" do
      valid_work_id = Work.first.id
      get work_path(valid_work_id)
      must_respond_with :success
    end

    it "returns not_found when given a invalid work ID" do
      invalid_work_id = Work.last.id + 1
      get work_path(invalid_work_id)
      must_respond_with :not_found
    end
  end

  describe "new" do
    
  end
end
