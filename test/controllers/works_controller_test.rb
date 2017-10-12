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

  # it "should get index" do
  #   get works_index_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get show" do
  #   get works_show_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get edit" do
  #   get works_edit_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get update" do
  #   get works_update_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get new" do
  #   get works_new_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get create" do
  #   get works_create_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get destroy" do
  #   get works_destroy_url
  #   value(response).must_be :success?
  # end

end
