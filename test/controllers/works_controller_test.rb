require "test_helper"

describe WorksController do
  it "should get home" do
    get '/works/home'
    must_respond_with :success
  end

  it "should get index" do
    get works_path
    must_respond_with :success
  end

  it "should get show" do
    get work_path(1)
    must_respond_with :success
  end

  it "should get new form" do
    get new_work_path
    must_respond_with :success
  end

  it "should post a new work" do
    proc {
      post works_path, params: { work: {title: "Pride and Prejudice", category: "movie", creator: "Joe Wright", publication_year: 2005 } }
    }.must_change 'Work.count', 1

    must_respond_with :redirect
    must_redirect_to works_path
  end

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
  # it "should get delete" do
  #   get works_delete_url
  #   value(response).must_be :success?
  # end

end
