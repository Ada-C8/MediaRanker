require "test_helper"

describe WorksController do

  it "successful gets home page" do
    get root_path
    must_respond_with :success
  end

  it "should successfully get to works index page" do
    get works_path
    must_respond_with :success
  end

  it "should successfully get to work show page" do
    get work_path(works(:test_book).id)
    must_respond_with :success
  end

  it "should successfully get to work edit page" do
    get edit_work_path(works(:test_book).id)
    must_respond_with :success
  end

  it "should successfully patch work" do
    get edit_work_path(works(:test_book).id)
    must_respond_with :success
  end

  it "should update titles of works" do
    patch work_path(works(:test_book).id), params: {work: {category: "book", title: "Definitely not 1984", creator: "George Orwell"} }
    test = Work.find(works(:test_book).id)
    test.title.must_equal "Definitely not 1984"
  end

  it "should update description of works" do
    patch work_path(works(:test_book).id), params: {work: {category: "book", title: "Definitely not 1984", creator: "George Orwell", description: "An updated description"} }
    test = Work.find(works(:test_book).id)
    test.description.must_equal "An updated description"
  end

  it "should update creators of works" do
    patch work_path(works(:test_book).id), params: {work: {category: "book", title: "1984", creator: "Not George Orwell"} }
    test = Work.find(works(:test_book).id)
    test.creator.must_equal "Not George Orwell"
  end

  it "should update categories of works" do
    patch work_path(works(:test_book).id), params: {work: {category: "album", title: "Definitely not 1984", creator: "George Orwell"} }
    test = Work.find(works(:test_book).id)
    test.category.must_equal "album"
  end

  it "should successfully get new page" do
    get new_work_path
    must_respond_with :success
  end

  it "should be able to create a new work" do
    post works_path, params: {work: {category: "book", title: "1984", creator: "George Orwell"}}
    must_respond_with :redirect
    must_redirect_to works_path

    proc   {
      post works_path, params: {work: {category: "book", title: "1984", creator: "George Orwell"}}
    }.must_change 'Work.count', 1
  end

  it "should successfully delete work" do
    delete work_path(works(:test_book).id)
    must_respond_with :redirect
    must_redirect_to works_path

    proc   {
      delete work_path(works(:another_test).id)
    }.must_change 'Work.count', -1
  end
end
