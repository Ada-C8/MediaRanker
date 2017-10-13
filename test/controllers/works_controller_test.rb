require "test_helper"

describe WorksController do
  it "should display a list of all works" do
    get works_path
    must_respond_with :success
  end

  it "should be able to show an individual work's page" do
    get work_path(works(:greys).id)
    must_respond_with :success
  end

  it "should be produce a form to make a new page" do
    get new_work_path
    must_respond_with :success
  end

  it "should be able to create a new work" do
    post works_path, params: {work: {title: "New Title", category: "movie"} }
    must_respond_with :redirect
    must_redirect_to works_path
  end

  it "should produce an edit form" do
    get edit_work_path(works(:greys).id)
    must_respond_with :success
  end

  it "should update a work through the update path" do
    patch work_path(works(:greys).id), params: {work: {title: "Update this work", category: "movie"}}
    update_work = Work.find(works(:greys).id)
    update_work.title.must_equal "Update this work"
    must_redirect_to works_path
  end

  it "should be able to destroy a work" do
    delete work_path(works(:greys).id)
    must_respond_with :redirect
    must_redirect_to works_path
  end

  it "root_path shoudl direct to the home page" do
    get top_works_path
    must_respond_with :success
  end
end
