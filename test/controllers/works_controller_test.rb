require "test_helper"

describe "WorksController" do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe "index" do
    it "returns a success status for all works" do
      get works_path
      must_respond_with :success
    end

    it "returns a success status when there are no works" do
      Work.destroy_all
      get works_path
      must_respond_with :success
    end

  end

  describe "new" do
    it "returns a success status for creating a new work" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "adds the work to the database and redirects when the work data is valid" do
      #arrange
      work_data = {
        work: {
          category: "book",
          title: "When Nietzsche Wept",
          creator: "Irvin Yalom",
          publication_year: 1990,
          description: "Read it"
        }
      }

      Work.new(work_data[:work]).must_be :valid?

      start_work_count = Work.count

      #act
      post works_path, params: work_data

      #assert
      must_respond_with :redirect
      must_redirect_to works_path

      Work.count.must_equal start_work_count + 1
    end
  end

end
