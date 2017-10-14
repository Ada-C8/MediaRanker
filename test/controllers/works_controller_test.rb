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

    it "sends bad request when the work data is bogus" do
      # Arrange
      invalid_work_data = {
        work: {
          publication_year: 2003,
          category: "book",
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
    it "returns success when given a valid work id" do
      work_id = Work.first.id
      get edit_work_path(work_id)
      must_respond_with :success
    end

    it "returns not found when given an invalid work ID" do
      invalid_work_id = Work.last.id + 1
      get edit_work_path(invalid_work_id)
      must_respond_with :not_found
    end
  end

  # describe "update" do
  #   it "returns success if the work ID is valid and the change is valid" do
  #     work = Work.first
  #       work_data = {
  #         work: {
  #           title: "Toy Story",
  #           category: "movie",
  #           publication_year: 1995,
  #           creator: "Pixar"
  #         }
  #       }
  #       work.update_attributes(work_data[:book])
  #       work.must_be :valid?, "Test is invalid because the provided data will produce an invalid work"
  #
  #       patch book_path(work), params: work_data
  #
  #       must_respond_with :redirect
  #       must_redirect_to work_path(work)
  #
  #       work.reload
  #       work.title.must_equal work_data[:work][:title]
  #   end
  #
  #   it "returns not found if the book ID is invalid" do
  #     invalid_work_id = Work.last.id + 1
  #       work_data = {
  #         work: {
  #           title: "Purple Hibiscus",
  #           category: "book",
  #           publication_year: 2003,
  #           creator: "Chimamanda Ngozi Adichie"
  #         }
  #       }
  #
  #       patch work_path(invalid_work_id), params: work_data
  #
  #       must_respond_with :not_found
  #   end
  #
  #   it "returns bad request if the change is invalid" do
  #     work = Work.first
  #     invalid_work_data = {
  #       work: {
  #         title: ""
  #       }
  #     }
  #     # Check that the update is actually invalid
  #     work.update_attributes(invalid_work_data[:work])
  #     work.wont_be :valid?
  #
  #     patch work_path(work), params: invalid_work_data
  #
  #     must_respond_with :bad_request
  #
  #     work.reload
  #     work.title.wont_equal invalid_work_data[:work][:title]
  #   end
  # end

  describe "show" do
    it "returns success when given a valid work id" do
      # Arrange
      work_id = Work.first.id #pull id out of db,doesn't matter which work

      # Act
      get work_path(work_id)

      # Assert
      must_respond_with :success
    end

    it "returns not found when given an invalid work ID" do
      invalid_work_id = Work.last.id + 1
      get work_path(invalid_work_id)
      must_respond_with :not_found
    end
  end

  describe "destroy" do
    it "returns success and destroys the work when given a valid work ID" do
      # Arrange
      work_id = Work.first.id

      # Act
      delete work_path(work_id)

      # Assert
      must_respond_with :redirect
      must_redirect_to works_path
      Work.find_by(id: work_id).must_be_nil
    end

  #   it "returns not_found when given an invalid work ID" do
  #    invalid_work_id = Work.last.id + 1
   #
  #    start_work_count = Work.count
   #
  #    delete work_path(invalid_work_id)
   #
  #    must_respond_with :not_found
  #    Work.count.must_equal start_work_count
  #  end

  end
end
