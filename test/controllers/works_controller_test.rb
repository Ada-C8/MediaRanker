require "test_helper"

describe WorksController do
  it "successfully loads homepage" do
    get root_path
    must_respond_with :success
  end

  it "successfully loads works index page to list all works" do
    get works_path
    must_respond_with :success
  end

  it "successfully loads a new work form" do
    get new_work_path
    must_respond_with :success
  end

  it "successfully loads an individual work(#show)page" do
    get work_path( works(:book1).id )
    must_respond_with :success
  end

  it "Edits: successfully loads an individual work's edit page " do
    get edit_work_path(works(:book1).id)
    must_respond_with :success
  end

  it "Updates: successfully updates an individual work's edit page " do
    put work_path( works(:book1)), params: { work: { title: "Book_Title"} }

    updated_work = Work.find( works(:book1).id )

    updated_work.title.must_equal "Book_Title"

    must_redirect_to work_path( works(:book1).id )
  end

end
