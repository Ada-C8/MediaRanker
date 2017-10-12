require "test_helper"

describe WorksController do
  describe "index" do
    it "returns a success status" do
      @work = Work.new(category: "book", title: "Purple Hibiscus", creator: "Chimamanda", publication_year: 2006, description: "Riveting")
      
      get works_path

      must_respond_with :success
    end

    it "returns a success status when there are no works" do
      @work = Work.new(category: "book", title: "Purple Hibiscus", creator: "Chimamanda", publication_year: 2006, description: "Riveting")

      Work.destroy_all
      get works_path

      must_respond_with :success
    end

    it "returns success status when given a valid work" do
      @work = Work.new(category: "book", title: "Purple Hibiscus", creator: "Chimamanda", publication_year: 2006, description: "Riveting")

      get works_path(@work)
      must_respond_with :success
    end
  end
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
end
