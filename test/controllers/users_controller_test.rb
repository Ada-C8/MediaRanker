require "test_helper"

describe UsersController do
  it "should get index" do
    get users_index_url
    value(response).must_be :success?
  end

  it "index page successful" do
    get works_path
    must_respond_with :success
  end

  it "should get new" do
    get users_new_url
    value(response).must_be :success?
  end


  it "loads new_work" do
    get new_work_path
    must_respond_with :success
  end

  it "should get show" do
    get users_show_url
    value(response).must_be :success?
  end

  it "should get create" do
    get users_create_url
    value(response).must_be :success?
  end

  it "creates & saves a new work" do
    proc {
      post works_path, params: { work: {category: "album", title: "Red", creator: "Lindsey", publication_year: "1952", description: "Check"}}
    }.must_change 'Work.count', 1

    must_respond_with :redirect
    must_redirect_to works_path
  end

  it "creates a new work in the database" do
    proc {
      post works_path, params: { work: {category: "movie", title: "A Beautiful Mind", creator: "Someone", publication_year: 1999}}
    }.must_change 'Work.count', 1

    work = Work.find_by(title: "A Beautiful Mind")
    work.creator.must_equal "Someone"
    work.publication_year.must_equal 1999

  end

  it "should get edit" do
    get users_edit_url
    value(response).must_be :success?
  end

  it "should get update" do
    get users_update_url
    value(response).must_be :success?
  end

  it "should get destroy" do
    get users_destroy_url
    value(response).must_be :success?
  end

end #describe do
