require "test_helper"

describe WorksController do
  let(:book) {works(:hp)}
  it "should get index" do
    get works_path
    must_respond_with :success
  end
  #
  # it "should get new" do
  #   get works_new_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get edit" do
  #   get works_edit_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get create" do
  #   get works_create_url
  #   value(response).must_be :success?
  # end
  #
  it "should get show" do
    get work_path(book.id)
    must_respond_with :success
  end
  #
  it "should get update" do
    put work_path(works(:hp).id), params: {work: {title: "Harry and The Stone"} }
    book = Work.find(works(:hp).id)
    book.title.must_equal "Harry and The Stone"
    must_respond_with :redirect
    must_redirect_to works_path
  end
  #
  # it "should get destroy" do
  #   get works_destroy_url
  #   value(response).must_be :success?
  # end

end
