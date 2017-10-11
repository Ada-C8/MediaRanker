require "test_helper"

describe WorksController do
  let(:book) {works(:hp)}
  it "should get index" do
    get works_path
    must_respond_with :success
  end

  it "should get new" do
    get new_work_path
    must_respond_with :success
  end

  it "should get edit" do
    get edit_work_path(book.id)
    must_respond_with :success
  end

  it "should create" do
    proc {
      post works_path, params: {work: {title: "New Title",creator:"Me",publication_year:2014,category:"movie"}}
    }.must_change 'Work.count', 1
    must_respond_with :redirect
    must_redirect_to works_path
  end

  it "should get show" do
    get work_path(book.id)
    must_respond_with :success
  end

  it "should render 404 page if not found" do
    get work_path(-1)
    assert_response 404
  end

  it "should update" do
    put work_path(book.id), params: {work: {title: "Harry and The Stone"} }
    work = Work.find(book.id)
    work.title.must_equal "Harry and The Stone"
    must_respond_with :redirect
    must_redirect_to works_path
  end

  it "will redirect if not updated" do
    skip
    put work_path(book.id), params: {work: {title: nil} }
    must_redirect_to edit_work_path
  end

  it "should destroy" do
    delete work_path(book.id)
    must_respond_with :redirect
    must_redirect_to works_path
  end

end
