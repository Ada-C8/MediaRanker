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

  it "creates a new work in the database correctly" do
    proc {
      post works_path, params: { work: {category: "movie", title: "Anna Karenina", creator: "Tolstoy", publication_year: 1807, description: "description"}}
    }.must_change 'Work.count', 1

    work = Work.find_by(title: "Anna Karenina")
    work.creator.must_equal "Tolstoy"
    # work.publication_year.must_equal 1807
    # work.description.must_equal "description"
  end

  it "successfully loads the edit work form" do
    get edit_work_path( works(:movie) )
    must_respond_with :success
  end

  it "should be able to successfully update a title of work" do
    put work_path( works(:album)), params: { work: { title: "Updated Title"} }
    updated_work = Work.find( works(:album).id )
    updated_work.title.must_equal "Updated Title"
    must_redirect_to works_path
  end

  it "should be able to successfully update a category of a work" do
    put work_path( works(:album)), params: { work: { category: "book"} }
    updated_work = Work.find( works(:album).id )
    updated_work.category.must_equal "book"
    must_redirect_to works_path

  end

  it "should be able to successfully update a creator of a work" do
    put work_path( works(:album)), params: { work: { creator: "Nathan K"} }
    updated_work = Work.find( works(:album).id )
    updated_work.creator.must_equal "Nathan K"
    must_redirect_to works_path
  end

  it "should be able to successfully update the publication year of a work" do
    put work_path( works(:album)), params: { work: { publication_year: 2005} }
    updated_work = Work.find( works(:album).id )
    updated_work.publication_year.must_equal 2005
    must_redirect_to works_path
  end

  it "should be able to update the description of a work" do
    put work_path( works(:album)), params: { work: {description: "new description"} }
    updated_work = Work.find( works(:album).id )
    updated_work.description.must_equal "new description"
    must_redirect_to works_path
  end

end
