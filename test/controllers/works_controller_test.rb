require "test_helper"

describe WorksController do

  it "going to the works index page is successful" do
    # Arrange

    # Act
    get works_path

    # Assert
    must_respond_with :success
  end

  it "should be able to visit an individual works show page" do
    # Arrange

    # Act
    get work_path( works(:chansons).id )

    # Assert
    must_respond_with :success
  end

  it "should be the new work form" do
    # Arrange

    # Act
    get new_work_path

    # Assert
    must_respond_with :success
  end

  it "should be able to edit a previous work" do
    # Arrange

    # Act
    get edit_work_path( works(:chansons).id )

    # Assert
    must_respond_with :success
  end

  it "should be able to successfully create a book" do
    proc {
      post works_path, params: { work: { title: "New Title", creator: "rowling", category: "book", publication_year: 1999 } }
    }.must_change 'Work.count', 1

    must_respond_with :redirect
    must_redirect_to root_path
  end

  it "should rerender the form if it can't create the work" do
    proc {
      post works_path, params: { work: { title: "New Title", creator: "rowling", category: "book" } }
    }.must_change 'Work.count', 0

    must_respond_with :success
  end

  it "should be able to successfully update a work title" do
    put work_path( works(:amelie) ), params: { work: { title: "Updated Title" } }

    updated_work = Work.find( works(:amelie).id )

    updated_work.title.must_equal "Updated Title"

    must_redirect_to works_path
  end

  it "should be able to delete a work" do
    work_id = works(:amelie).id
    proc {
      delete work_path( works(:amelie) )
    }.must_change 'Work.count', -1

    must_redirect_to root_path

    Work.find_by(id: work_id).must_equal nil
  end
end
