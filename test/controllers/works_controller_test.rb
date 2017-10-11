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

end
