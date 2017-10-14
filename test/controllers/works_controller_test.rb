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

  end

  describe "show" do
    it "returns a success status" do
      get work_path(works(:hellodolly).id)
      must_respond_with :success
    end

    it "wont route for invalid id" do
      id = works(:hellodolly).id
      delete work_path(id)
      get work_path(id)
      must_respond_with :error
      # must_redirect_to works_path
    end

    it "controller changes related model- deleting a work lowers the number of work objects" do
      proc {delete work_path(works(:hellodolly).id) }.must_change 'Work.count', -1

    # must_respond_with :redirect
    # must_redirect_to work_path
    end
  end

  describe "edit" do

  end

  describe "new" do

  end

  describe "create" do
    it "should be able to create a post" do
      proc {post works_path, params: { work: {category: "movie", title: "Indian Jones and the Last Crusade", creator: "la la la", pub_year: "1989", description: "he keeps losing his hat"} } }.must_change 'Work.count', 1

      must_respond_with :redirect
      must_redirect_to works_path
    end

  end

  describe "update" do

  end

  describe "destroy" do

  end


end
