require "test_helper"

describe WorksController do
  it "the books index page is successful" do
    get works_path
    must_respond_with :success
  end

  it "successfully loads the new_work form" do
    get new_work_path
    must_respond_with :success
  end

  it "creates a new work that saves to the database" do
    proc {
      post works_path, params: { work: {category: "album", title: "New Title", creator: "Newton", publication_year: "1983", description: "This is a fantastic album. You should listen to it!"}}
    }.must_change 'Work.count', 1

    must_respond_with :redirect
    must_redirect_to works_path
  end

end
