require "test_helper"

describe "WorksController" do
  it "should go to the index page" do
    get works_path
    must_respond_with :success
  end

  it "should visit an individual work's show page" do
    get work_path (works(:almost).id)
    must_respond_with :success
  end

  it "should create a work" do
    proc {
      post works_path, params: { work: {category: "movie", title: "This is It", creator: "The movie gods", publication_year: 2011, description: "a movie about the King of Pop"}}
    }.must_change 'Work.count', 1

    must_respond_with :redirect
    must_redirect_to works_path
  end

  it "should update a work" do
    put work_path ( works(:almost) ), params: { work: { title: "New Title" }}

    updated_work = Work.find( works(:almost).id )
    updated_work.title.must_equal "New Title"
    must_redirect_to works_path
  end

  it "should delete a work" do
    proc {
      delete work_path (works(:almost).id)
    }.must_change 'Work.count', -1
    must_respond_with :redirect
    must_redirect_to works_path
  end
end
