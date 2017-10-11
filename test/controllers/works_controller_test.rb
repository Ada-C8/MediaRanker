require "test_helper"

describe WorksController do
  let(:work) { works(:book1) }
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
  it "should get work detail page (#show) or render a 404" do
    get work_path(work.id)
    must_respond_with :success

    # get work_path(ada)
    # must_respond_with :error
  end
  #
  # it "should get create" do
  #   get works_create_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get update" do
  #   get works_update_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get edit" do
  #   get works_edit_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get destroy" do
  #   get works_destroy_url
  #   value(response).must_be :success?
  # end

end
