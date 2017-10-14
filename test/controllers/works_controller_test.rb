require "test_helper"

describe WorksController do
  describe "index" do
    it "returns a success status for all works" do
      get works_path
      must_respond_with :success
    end

    it "returns a success status when there are no books" do
     Work.destroy_all
     get works_path
     must_respond_with :success
    end

   it "goes to the works details page" do
    get work_path(works(:awesome_movie).id)
    must_respond_with :success
    end

  #question should be what will cause the index page not to show. since it is ordered by title then if title isn't present maybe it wont show??  I wonder if I could mess with the form and that could result in html not rendering properly. perhaps!

#not sure what to do with this yet,  need an invalid case.  do I need to check work id
  # it "returns something when given an invalid category" do
  #   proc {
  #         get works_path(category: "play")}.must_raise ActionController::UrlGenerationError
  # end
end

  describe "new" do
    it "returns a new work" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "does something when the work data is valid" do
      work_data = {
        work: {
          title: "Purple Hibiscus",
          category: "book",
          publication_year: 2003,
          creator: "Chimamanda Ngozi Adichie"
        }
      }
      # Test data should result in a valid work, else test is broken(test will break if a model is changed in the future)
      Work.new(work_data[:work]).must_be :valid?

      start_work_count = Work.count

      post works_path, params: work_data
      must_respond_with :redirect
      must_redirect_to works_path

      Work.count.must_equal start_work_count + 1
    end

    it "does something when the work data is bogus" do
      # Arrange
      invalid_work_data = {
        work: {
          title: "Purple Hibiscus",
          publication_year: 2003,
          creator: "Chimamanda Ngozi Adichie"
        }
      }
      # Double check data is truly invalid
      Work.new(invalid_work_data[:book]).wont_be :valid?

      start_work_count = Work.count
      
      # Act
      post works_path, params: invalid_work_data

      # Assert
      must_respond_with :bad_request

      Work.count.must_equal start_work_count

    end
  end

  describe "edit" do
  end

  describe "update" do
  end

  describe "show" do
  end

  describe "destroy" do
  end
  #   it "returns a success status" do
  #     @work = Work.new(category: "book", title: "Purple Hibiscus", creator: "Chimamanda", publication_year: 2006, description: "Riveting")
  #
  #     get works_path
  #
  #     must_respond_with :success
  #   end
  #
  #   it "returns a success status when there are no works" do
  #     @work = Work.new(category: "book", title: "Purple Hibiscus", creator: "Chimamanda", publication_year: 2006, description: "Riveting")
  #
  #     Work.destroy_all
  #     get works_path
  #
  #     must_respond_with :success
  #   end
  #
  #   it "returns success status when given a valid work" do
  #     @work = Work.new(category: "book", title: "Purple Hibiscus", creator: "Chimamanda", publication_year: 2006, description: "Riveting")
  #
  #     get works_path(@work)
  #     must_respond_with :success
  #   end

end
