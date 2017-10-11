require "test_helper"

describe "WorksController" do

  it "can successfully go to the home page" do
    get root_path
    must_respond_with :success
  end

  it "can successfully go to the works index page" do
    get works_path
    must_respond_with :success
  end

  it "should be able to visit in individual work show page" do
    get work_path( works(:twilight).id )
    must_respond_with :success
  end

  it "if try to show for work that doesn't exist does 404 error" do
    get work_path(-2)
    must_respond_with :not_found

  end

  it "should be able to create a work" do

    proc {post works_path, params: {work: {category: "movie", title: "New Movie"}}}.must_change 'Work.count', 1

    must_respond_with :redirect
    must_redirect_to works_path
  end

  it "should be able to successfully update work category" do
    put work_path( works(:twilight).id ), params: { work: {category: "movie"} }

    updated_work = Work.find( works(:twilight).id )
    updated_work.category.must_equal "movie"
    must_redirect_to work_path( works(:twilight).id )
  end

  it "should be able to successfully update work title" do
    put work_path( works(:twilight).id ), params: { work: {title: "Twilight 2"} }

    updated_work = Work.find( works(:twilight).id )
    updated_work.title.must_equal "Twilight 2"
    must_redirect_to work_path( works(:twilight).id )
  end

  it "should be able to delete a work" do
    proc {delete work_path( works(:twilight).id )}.must_change 'Work.count', -1

    must_respond_with :redirect
    must_redirect_to works_path
  end

end
