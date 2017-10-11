require "test_helper"

describe WorksController do
  it "should be able to visit the All Works (index) page" do

    get works_path

    must_respond_with :success

  end

  it " pulls up the main top ten page" do
    get root_path

    must_respond_with :success
  end

  it "should be able to visit a work's detail page" do
    #Arrange

      #Act
      get work_path(works(:book_one).id)

      #Assert
      must_respond_with :success
  end

  it "should be able to successfully create a new work" do

    proc {
      post works_path, params: { work: {category: "album", title: "Por Vida", creator: "Kali Uchis", publication_year: "2015", description: "Kali's debut EP"} }
    }.must_change 'Work.count', 1


    must_respond_with :redirect
    must_redirect_to work_path(Work.find_by(title: "Por Vida").id)

  end

  it "should redirect to the new work's detail page if it is created successfully" do


  end

  it "should stay on the add work page and display the error message banner if we are unsuccessful in creating or updating a work" do

  end

  it "should be able to update a work" do

  end

  it "should redirect to the show page if updated successfuly" do

  end

  it "renders to the same page if unsucessful create or update" do

  end

  describe 'creating a new Work' do
    it "requires only a title to create a new Work" do
      work = Work.new

      work.valid?.must_equal false

      work.title = "New Work"

      work.valid?.must_equal true
    end

    it "raises an error if there is a Work that has the same category AND same title" do
      existing_book = works(:book_one)
      new_book_same_title = Work.new(category: existing_book.category, title: existing_book.title)

      new_book_same_title.valid?.must_equal false

      new_book_same_title.errors.must_include :title
    end

    it "allows you to create a new Work that has the same title of a Work in a different category" do
      book_with_title = works(:book_one)
      album_with_same_title = Work.new(category: "album", title: book_with_title.title)

      album_with_same_title.valid?.must_equal true
    end
  end

end
