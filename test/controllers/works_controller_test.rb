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

  it "Creates: should be able to create a new work" do

  proc {
    post works_path, params: { work: { title: "New Work", category: 'album', creator: 'E.D.', publication_year: 2017, description: 'Long text about new work'} }
  }.must_change 'Work.count', 1

  #assert
  must_respond_with :redirect
  must_redirect_to works_path

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

  it "successfully deletes a work" do
    proc {
      delete work_path( works(:movie1))
    }.must_change 'Work.count', -1

    #assert
    must_respond_with :redirect
    must_redirect_to root_path
  end

end
