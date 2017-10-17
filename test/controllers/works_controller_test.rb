require "test_helper"

describe WorksController do
  it "should be able to visit the All Works (index) page" do

    get works_path

    must_respond_with :success

  end

  it "should be able to visit a work's detail page" do
    #Arrange

      #Act
      get work_path(works(:book_one).id)

      #Assert
      must_respond_with :success
  end

  describe "updating a work" do
    before do
      @work = works(:movie_one)
    end

    it "should not update a work if missing a title" do
      patch update_work_path(@work.id), params: { work: {category: "album", title: nil} }

      (@work.title).must_equal "Rosemary's Baby"
    end

    it "should be able to update a work with valid data and redirect to show page" do

      patch update_work_path(@work.id), params: { work: {category: "album", title: "new title"} }

      work = Work.find_by(id: @work.id)

      (work.title).must_equal "new title"

      must_respond_with :redirect
      must_redirect_to work_path(@work.id)

    end
  end



  describe 'creating a new Work' do
    it "should be able to visit the 'Add New Work' page " do
      get new_work_path
      must_respond_with :success
    end

    it "requires only a title to create a new Work" do
      work = Work.new

      work.valid?.must_equal false

      work.title = "New Work"

      work.valid?.must_equal true
    end

    it "does not allow you to create a Work that has the same category AND same title" do
      existing_book = works(:book_one)

      proc { post works_path, params: { work: {category: existing_book.category, title: existing_book.title} } }.must_change 'Work.count', 0

    end

    it "should be able to create a new work and redirect to the new work's detail page if successful" do

      proc {
        post works_path, params: { work: {category: "album", title: "Por Vida", creator: "Kali Uchis", publication_year: "2015", description: "Kali's debut EP"} }
      }.must_change 'Work.count', 1


      must_respond_with :redirect
      must_redirect_to work_path(Work.find_by(title: "Por Vida").id)

    end

    it "allows you to create a new Work that has the same title of a Work in a different category" do
      existing_movie = works(:movie_one)

      proc {
        post works_path, params: { work: {category: "album", title: existing_movie.title} }
      }.must_change 'Work.count', 1

    end

  end

  describe "Deleting a Work" do
    it "should successfully delete an existing work" do

      proc {
        delete work_path( works(:movie_one).id )
      }.must_change 'Work.count', -1

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  describe "The main, top works page" do
    it " pulls up the main top ten page" do
      get root_path

      must_respond_with :success
    end
  end

end
