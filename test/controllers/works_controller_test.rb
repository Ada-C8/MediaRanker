require "test_helper"

describe WorksController do

  describe "index" do
    it "the books index page is successful" do
      get works_path
      must_respond_with :success
    end
  end

  describe "new" do
    it "successfully loads the new_work form" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "creates a new work that saves to the database" do
      proc {
        post works_path, params: { work: {category: "album", title: "New Title", creator: "New Creator", publication_year: "1999", description: "Trials"}}
      }.must_change 'Work.count', 1

      must_respond_with :redirect
      must_redirect_to works_path
    end
    it "creates a new work in the database correctly" do
      proc {
        post works_path, params: { work: {category: "movie", title: "A Beauitful Mind", creator: "Mia Helmsley", publication_year: 2000, description: "description"}}
      }.must_change 'Work.count', 1

      work = Work.find_by(title: "A Beauitful Mind")
      work.creator.must_equal "Mia Helmsley"
      work.publication_year.must_equal 2000
      work.description.must_equal "description"
    end

  end

  describe "edit" do
    it "successfully loads the edit work form" do
      get edit_work_path( works(:movie) )
      must_respond_with :success
    end
  end

  describe "show" do
    it "successfully loads a show page for an individual work" do
      work = Work.find( works(:movie).id )
      get work_path(work.id)
      must_respond_with :success
    end
  end

  describe "delete" do
    # it "successfully deletes a work from the database" do
    #   post works_path, params: { work: {category: "movie", title: "A new movie", creator: "someone", publication_year: 2003, description: "description"}}
    #
    #   proc {
    #     delete work_path(Work.find_by(title: "Anna Karenina"))
    #   }.must_change 'Work.count', -1
    #
    #   must_respond_with :redirect
    #   must_redirect_to root_path
    # end

    it "should render 404 page if not found for destroy" do
      delete work_path(-1)
      assert_response 404
    end

      it "successfully loads the home page" do
         get root_path
         must_respond_with :success
       end



  end

  # describe "update" do
  #   it "should update with valid data" do
  #     put work_path(book.id), params: {work: {title: "Harry Potter"} }
  #     work = Work.find(book.id)
  #     work.title.must_equal "Harry Potter"
  #     must_respond_with :redirect
  #   end
  #
  #   it "should be able to successfully update a title of work" do
  #    put work_path( works(:album)), params: { work: { title: "Updated Title"} }
  #    updated_work = Work.find( works(:album).id )
  #    updated_work.title.must_equal "Updated Title"
  #    must_redirect_to works_path
  #  end
  #
  #  it "should be able to successfully update a category of a work" do
  #    put work_path( works(:album)), params: { work: { category: "book"} }
  #    updated_work = Work.find( works(:album).id )
  #    updated_work.category.must_equal "book"
  #    must_redirect_to works_path
  #
  #  end
  #
  #  it "should be able to successfully update a creator of a work" do
  #    put work_path( works(:album)), params: { work: { creator: "Nathan K"} }
  #    updated_work = Work.find( works(:album).id )
  #    updated_work.creator.must_equal "Nathan K"
  #    must_redirect_to works_path
  #  end
  #
  #  it "should be able to successfully update the publication year of a work" do
  #    put work_path( works(:album)), params: { work: { publication_year: 2005} }
  #    updated_work = Work.find( works(:album).id )
  #    updated_work.publication_year.must_equal 2005
  #    must_redirect_to works_path
  #  end
  #
  #  it "should be able to update the description of a work" do
  #    put work_path( works(:album)), params: { work: {description: "new description"} }
  #    updated_work = Work.find( works(:album).id )
  #    updated_work.description.must_equal "new description"
  #    must_redirect_to works_path
  #  end
  # end

end #for describe

# it "should get create" do
#   get works_create_url
#   value(response).must_be :success?
# end
#
# it "should get destroy" do
#   get works_destroy_url
#   value(response).must_be :success?
# end
#
# it "should get edit" do
#   get works_edit_url
#   value(response).must_be :success?
# end
#
# it "should get index" do
#   get works_index_url
#   value(response).must_be :success?
# end
#
# it "should get new" do
#   get works_new_url
#   value(response).must_be :success?
# end
#
# it "should get show" do
#   get works_show_url
#   value(response).must_be :success?
# end
#
# it "should get update" do
#   get works_update_url
#   value(response).must_be :success?
# end
#
# end
