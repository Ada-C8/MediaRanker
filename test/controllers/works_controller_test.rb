require "test_helper"

describe WorksController do
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

end
