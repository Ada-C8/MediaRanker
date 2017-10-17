require "test_helper"

describe WorksController do

  it "Should be able to get to works INDEX" do
    get works_path
    must_respond_with :success
  end

  it "Should be able to access a SHOW page based on a specific ID" do
    get work_path(works(:one).id)
    must_respond_with :success
  end

  it "Should be able to successfully CREATE a work" do
    proc  {
      post works_path, params: {work: {category: "movie", title: "home again", creator: "idk", publication_year: 2017, description: "woman lives the dream"}} }.must_change 'Work.count', 1

      must_respond_with :redirect
      must_redirect_to root_path
  end


  it "Should be able to DELETE/DESTROY a work" do
    proc  {
      delete work_path(works(:one).id)}.must_change 'Work.count', - 1
      must_redirect_to root_path
  end


  it "Should be able to EDIT a work" do
    put work_path(works(:one)), params: {work: {title: "Updated Title"}}
    updated_work = Work.find(works(:one).id)
    updated_work.title.must_equal "Updated Title"
    must_redirect_to root_path
  end

end
