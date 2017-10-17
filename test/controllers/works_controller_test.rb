require "test_helper"

describe WorksController do
  it "should get index" do
    get works_path
    value(response).must_be :success?
  end

  it "should get show" do
    get works_path(works(:wilco))
    value(response).must_be :success?
  end

  it "should get new" do
    get new_work_path
    value(response).must_be :success?
  end

  it "should get edit" do
    get edit_work_path(works(:wilco))
    must_respond_with :success
  end

  it "should get update" do
    patch work_path(works(:wilco)), params:{ work:
     { category: "book",
       title: "P.M.",
       publication_year: 2000,
       description: "Noon Songs",
       user: :cat  }}

   must_respond_with :redirect
  end

  it "create should update database" do
    proc { post works_path, params: { work:
          { title: "Sad Times of Captain Meow",
            publication_year: 2017,
            description: "Made up",
            creator: "A Cat, Probably",
            category: "book",
          }
        }
      }.must_change 'Work.count', 1
  end

  it "destroy should update database" do
    proc {
     delete work_path(works(:wilco))
   }.must_change 'Work.count', -1
  end

  it "must delete a work and redirect to works" do
    delete work_path(works(:wilco))
    must_redirect_to works_path
  end

end
