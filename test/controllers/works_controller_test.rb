require "test_helper"


describe WorksController do
  it "going to the works index is successful" do
    get works_path
    must_respond_with :success
  end

  it "should be able to visit an individual work show page" do
    get work_path(works(:bonito).id)
    must_respond_with :success
  end

  it "should be able to create a work" do
    proc {
      post works_path, params: {work: {category: "album", title: "bury me at makeout creek", creator: "mitski", publication_year: 2014, description: "i dont smoke"}}
    }.must_change 'Work.count', 1
    must_respond_with :redirect
    must_redirect_to works_path
  end

  it "should get update" do
    get edit_work_path(works(:bonito).id)
    must_respond_with :success
  end

  it "should get new" do
    get new_work_path
    must_respond_with :success
  end





end
