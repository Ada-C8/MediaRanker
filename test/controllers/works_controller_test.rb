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

  it "should be able to edit a work" do
    patch work_path(works(:bonito).id), params: {work: {title: "updated title"}}
    updated_work = Work.find( works(:bonito).id)
    updated_work.title.must_equal "updated title"
    must_redirect_to work_path(works(:bonito).id)
  end

  it "should render edit page if not successful" do
    # patch work_path(works(:bonito).id), params: {work: {id: 9000}}
    # get :edit
    # # must_respond_with :error

  end

  it "should get new" do
    get new_work_path
    must_respond_with :success
  end





end
