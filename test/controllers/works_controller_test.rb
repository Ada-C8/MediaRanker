require "test_helper"


describe WorksController do
  it "guest: going to the works index is not successful" do
    get works_path
    must_respond_with :redirect
  end

  it "guest: should not be able to visit an individual work show page" do
    get work_path(works(:bonito).id)
    must_respond_with :redirect
  end

  it "guest: should be not able to create a work" do
    proc {
      post works_path, params: {work: {category: "album", title: "bury me at makeout creek", creator: "mitski", publication_year: 2014, description: "i dont smoke"}}
    }.must_change 'Work.count', 0
    must_respond_with :redirect
    must_redirect_to root_path
  end

  it "guest: should not be able to get update" do
    get edit_work_path(works(:bonito).id)
    must_respond_with :redirect
    must_redirect_to root_path
  end

  it "guest: should not  be able to edit a work" do
    patch work_path(works(:bonito).id), params: {work: {title: "updated title"}}
    updated_work = Work.find( works(:bonito).id)
    updated_work.title.must_equal works(:bonito).title
    must_redirect_to root_path
  end

  it "should render edit page if not successful" do
    # patch work_path(works(:bonito).id), params: {work: {id: 9000}}
    # get :edit
    # # must_respond_with :error

  end

  it "guests: should not get new" do
    get new_work_path
    must_respond_with :redirect
  end

  it "guest: should not be able to visit an individual work show page" do
    get work_path(works(:bonito).id)
    must_respond_with :redirect
    must_redirect_to root_path
  end

  it "guest: should respond with a redirect to root if book not found" do
    get work_path(9080948)
    must_respond_with :redirect
    must_redirect_to root_path

  end

  it "guest: should not be able to successfully delete a work" do
    proc {
      (delete work_path(works(:pride).id))
    }.must_change 'Work.count', 0
    must_redirect_to root_path
  end

  it "guest: should respond with redirect to root if book up for deletion does not exist" do
    proc {
      (delete work_path(3908))
    }.must_change 'Work.count', 0
    must_redirect_to root_path
  end

  it "guest: should not upvote a work" do
    proc {
      post upvote_path(works(:lotr).id)
    }.must_change 'Vote.count', 0
    must_respond_with :redirect
    must_redirect_to root_path
  end



end
