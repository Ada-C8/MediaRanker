require "test_helper"

describe WorksController do

  describe "index" do
    it "returns a success status" do
      get works_path
      must_respond_with :success
    end

    it "returns an error when given a bogus work_id" do
      bad_work_id = Work.last.id + 1
      get work_path(bad_work_id)
      must_respond_with :not_found
    end

    it "returns an error when there are no books, albums or movies" do

    end

  end

  describe "show" do

  end

  describe "edit" do

  end

  describe "new" do

  end

  describe "create" do

  end

  describe "update" do

  end

  describe "destroy" do

  end


end
