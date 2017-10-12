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
