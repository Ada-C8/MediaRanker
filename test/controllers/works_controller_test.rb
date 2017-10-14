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
    get work_path(works(:album).id)
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

  it "should get edit" do
    get edit_work_path(works(:book).id)
    must_respond_with :success
  end

  it "should update a post" do
    put work_path(works(:movie).id), params: {work: {title: "Eat Drink Man Woman", description: "A chef and father makes elaborate meals for his three daughters every Sunday"} }

    movie = Work.find_by(id: works(:movie).id)
    movie.title.must_equal "Eat Drink Man Woman"
    movie.description.must_equal "A chef and father makes elaborate meals for his three daughters every Sunday"

    must_respond_with :redirect
  end

  # it "requires update data to be valid" do
  #   put work_path(works(:book).id), params: { {work: {title: nil}} }
  #
  # end
  #
  it "should delete a record" do
    proc {
      delete work_path(works(:album).id)
    }.must_change 'Work.count', -1

    must_redirect_to root_path
  end

end
